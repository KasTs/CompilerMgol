require_relative 'aux/lexico/afd'
require_relative 'aux/lexico/token_class'
require_relative 'aux/lexico/tabela_simbolos'
require_relative 'aux/sintatico/actions'
require_relative 'aux/sintatico/goto'
require_relative 'aux/sintatico/regras_gramatica'

@line = 1
@column = 0

def scanner()

	estado_atual = "Q0"
	lexema = ''

	loop do

		#se chegou ao final do arquivo, confere se estava lendo um lexema válido no momento
		if @f.eof?
			if @afd[estado_atual]["FINAL"] == true
				token = Token.new(@afd[estado_atual]["CLASSE"],lexema,nil)
				return check_simbol(token)
				
			else
				return Token.new("ERRO1",lexema,nil)
			end
		end

		c = @f.readchar

		@column+=1
		if c == "\n"
			@line+=1
			@column = 0
		end

		#puts "Caractere lido: " + c
		lexema += c

		#ignora se for caractere dentro de comentário ou literal
		redo if estado_atual == "Q8" and c != "\""
		redo if estado_atual == "Q10" and c != '}'

		if estado_atual == 'Q3' and (c == 'e' or c == 'E')
			tipo_char = "Ee"
		elsif (c.ord >= 65 && c.ord <=90) or (c.ord >= 97 and c.ord <=122)
			tipo_char = "LETRA"
		elsif c.ord >= 48 and c.ord <= 57
			tipo_char = "DIGITO"
		elsif c == "\""
			tipo_char = "ASPAS"
		elsif c == "."
			tipo_char = "."
		elsif c == "+"
			tipo_char = "+"
		elsif c == "-"
			tipo_char = "-"
		elsif c == "*"
			tipo_char = "*"
		elsif c == "/"
			tipo_char = "/"
		elsif c == "<"
			tipo_char = "<"
		elsif c == ">"
			tipo_char = ">"
		elsif c == "="
			tipo_char = "="
		elsif c == "("
			tipo_char = "("
		elsif c == ")"
			tipo_char = ")"
		elsif c == ";"
			tipo_char = ";"
		elsif c == ","
			tipo_char = ","
		elsif c == "{"
			tipo_char = "{"
		elsif c == "}"
			tipo_char = "}"
		elsif c == "\n" or c== " " or c== "\r"  or c== "\f"  or c== "\v" or c== "\t"
			tipo_char = "ESPAÇO_VAZIO"
		else 
			tipo_char = "INVALIDO"
		end

		#puts "Tipo char:" + tipo_char

		if tipo_char == "INVALIDO"
			return Token.new("ERRO1",lexema,nil)
		end

		if tipo_char == "ESPAÇO_VAZIO"
			if estado_atual == "Q0"
				return nil
			elsif @afd[estado_atual]["FINAL"] == true
				token = Token.new(@afd[estado_atual]["CLASSE"],lexema.chop,nil)
				return check_simbol(token)
			else
				return Token.new("ERRO2",lexema.chop,nil)
			end
		end

		#se houver uma transição pro caractere lido...
		if @afd[estado_atual][tipo_char]
			#puts "Transição: " + estado_atual + "=>" + afd[estado_atual][tipo_char]
			estado_atual = @afd[estado_atual][tipo_char]
		else
				if estado_atual == 'Q0'
					return Token.new("ERRO2",lexema,nil)
				elsif @afd[estado_atual]["FINAL"] == true
					@f.seek(-1,IO::SEEK_CUR)
					@column-=1
					token = Token.new(@afd[estado_atual]["CLASSE"],lexema.chop,nil)
					return check_simbol(token)
				else
					@f.seek(-1,IO::SEEK_CUR)
					@column-=1
					return Token.new("ERRO2",lexema.chop,nil)
				end		
		end

	end
end

def error(num)
	if num == 1
		puts "\nErro léxico 1 - Caractere inválido na linguagem, linha #{@line} e coluna #{@column}"
	else
		puts "\nErro léxico 2 - Sequencia invalida na linguagem, linha #{@line} e coluna #{@column}"
	end
end

def check_simbol(token)
	if token.classe == "id"
		@tabela_simbolos.each do |registro_ts|
			if token.lexema == registro_ts.lexema
				return registro_ts
			end
		end
		@tabela_simbolos.push(token)
		return token
	else 
		return token
	end	
end

@f = File.new("teste.txt")

 token = scanner()
 a = token.classe
 pilha = ["$","0"]

loop do

	s = pilha.last

	#tratamento de erro: modo pânico
	if !@actions[s][a]

		puts "Erro de sintaxe - token inesperado: \"#{token.lexema}\" na linha #{@line}, coluna #{@column}. Tokens esperados: #{@actions[s].keys}" 

		while !@actions[s][a] do
			if @f.eof?
				exit
			else 
				token = scanner()
				a = token.classe
			end
		end

	elsif @actions[s][a].start_with?("S")
		#empilha t na pilha
		t = @actions[s][a].delete_prefix("S")		
		pilha.push(t)

		#lê o próximo token válido
		loop do

			if @f.eof?
				a = "$"
			else 
				token = scanner()
				if token
					a = token.classe
				end

				if token && token.classe.start_with?("ERRO")
					error(token.classe[-1..-1].to_i)
				end
			end

			valid_token = !( !token || token.classe == "Comentário" || token.classe.start_with?("ERRO"))

			break if valid_token
		end

	elsif @actions[s][a].start_with?("R")		
		num_regra = @actions[s][a].delete_prefix("R")
		regra = @gram[num_regra.to_i]

		#desempilha |b| simbolos
		tam_beta = regra.split("→")[1].split(" ").size
		pilha.pop(tam_beta)

		#empilha GOTO[t][A]
		t = pilha.last
		alpha = regra.split("→")[0]
		pilha.push(@goto[t][alpha])

		puts regra

	elsif @actions[s][a] == "ACC"
		puts "P' -> P"
		break		
	end
end