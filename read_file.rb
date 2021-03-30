afd = Hash.new

afd = {
	"Q0" => { 
		"LETRA" => "Q7",
		"DIGITO" => "Q1",
		"ASPAS" => "Q8",
		"+" => "Q19",
		"-" => "Q19",
		"*" => "Q19",
		"/" => "Q19",
		"<" => "Q13",
		">" => "Q16",
		"=" => "Q12",
		"(" => "Q20",
		")" => "Q21",
		";" => "Q22",
		"," => "Q23",
		"{" => "Q10",
		"FINAL" => false,
	},
	"Q1" => {
		"DIGITO" => "Q1",
		"." => "Q2",
		"FINAL" => true,
		"CLASSE" => "Num"
	},
	"Q2" => {
		"DIGITO" => "Q3",
		"FINAL" => false
	},
	"Q3" => {
		"DIGITO" => "Q3",
		"Ee" => "Q4",
		"FINAL" => true,
		"CLASSE" => "Num"
	},
	"Q4" => {
		"DIGITO" => "Q5",
		"+" => "Q6",
		"-" => "Q6",
		"FINAL" => false,
	},
	"Q5" => {
		"FINAL" => true,
		"CLASSE" => "Num"
	},
	"Q6" => {
		"DIGITO" => "Q5",
		"FINAL" => false
	},
	"Q7" => {
		"LETRA" => "Q7",
		"DIGITO" => "Q7",
		"_" => "Q7",
		"FINAL" => true,
		"CLASSE" => "id"
	},
	"Q8" => {
		"ASPAS" => "Q9",
		"FINAL" => false
	},
	"Q9" => {
		"FINAL" => true,
		"CLASSE" => "Literal"
	},
	"Q10" => {
		"}" => "Q11",
		"FINAL" => false
	},
	"Q11" => {
		"FINAL" => true,
		"CLASSE" => "Comentário"
	},
	"Q12" => {
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q13" => {
		">" => "Q15",
		"=" => "Q15",
		"-" => "Q14",
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q14" => {
		"FINAL" => true,
		"CLASSE" => "RCB"
	},
	"Q15" => {
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q16" => {
		"=" => "Q17",
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q17" => {
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q18" => {
		"FINAL" => true,
		"CLASSE" => "EOF"
	},
	"Q19" => {
		"FINAL" => true,
		"CLASSE" => "OPM"
	},
	"Q20" => {
		"FINAL" => true,
		"CLASSE" => "AB_P"		
	},
	"Q21" => {
		"FINAL" => true,
		"CLASSE" => "FC_P"	
	},
	"Q22" => {
		"FINAL" => true,
		"CLASSE" => "PT_V"
	},
	"Q23" => {
		"FINAL" => true,
		"CLASSE" => "VIR"
	}
}

@line = 1
@column = 0

class Token

	def initialize(classe,lexema,tipo)
		@classe = classe
		@lexema = lexema
		@tipo = tipo
	end

	attr_reader :classe
	attr_reader :lexema
	attr_reader :tipo
end

def scanner(afd)

	estado_atual = "Q0"
	lexema = ''

	loop do

		#se chegou ao final do arquivo, confere se estava lendo um lexema válido no momento
		if @f.eof?
			if afd[estado_atual]["FINAL"] == true
				token = Token.new(afd[estado_atual]["CLASSE"],lexema,nil)
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
			elsif afd[estado_atual]["FINAL"] == true
				token = Token.new(afd[estado_atual]["CLASSE"],lexema.chop,nil)
				return check_simbol(token)
			else
				return Token.new("ERRO2",lexema.chop,nil)
			end
		end

		#se houver uma transição pro caractere lido...
		if afd[estado_atual][tipo_char]
			#puts "Transição: " + estado_atual + "=>" + afd[estado_atual][tipo_char]
			estado_atual = afd[estado_atual][tipo_char]
		else
				if estado_atual == 'Q0'
					return Token.new("ERRO2",lexema,nil)
				elsif afd[estado_atual]["FINAL"] == true
					@f.seek(-1,IO::SEEK_CUR)
					@column-=1
					token = Token.new(afd[estado_atual]["CLASSE"],lexema.chop,nil)
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
		puts "\nERRO 1 - Caractere inválido na linguagem, linha #{@line} e coluna #{@column}"
	else
		puts "\nERRO 2 - Sequencia invalida na linguagem, linha #{@line} e coluna #{@column}"
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

@tabela_simbolos = Array.new

@tabela_simbolos.push(Token.new("inicio","inicio",nil))
@tabela_simbolos.push(Token.new("varinicio","varinicio",nil))
@tabela_simbolos.push(Token.new("varfim","varfim",nil))
@tabela_simbolos.push(Token.new("escreva","escreva",nil))
@tabela_simbolos.push(Token.new("leia","leia",nil))
@tabela_simbolos.push(Token.new("se","se",nil))
@tabela_simbolos.push(Token.new("entao","entao",nil))
@tabela_simbolos.push(Token.new("fimse","fimse",nil))
@tabela_simbolos.push(Token.new("faca-ate","faca-ate",nil))
@tabela_simbolos.push(Token.new("fimfaca","inicio",nil))
@tabela_simbolos.push(Token.new("inteiro","inteiro",nil))
@tabela_simbolos.push(Token.new("lit","lit",nil))
@tabela_simbolos.push(Token.new("real","real",nil))

loop do

	token = scanner(afd)

	if token
		puts "\nClasse: " + token.classe + " Lexema: " + token.lexema + " Tipo: Nulo"  
	end

	if token && token.classe.start_with?("ERRO")
		error(token.classe[-1..-1].to_i)
	end

	if @f.eof?
		token = Token.new("EOF","EOF",nil)
		puts "\nClasse: " + token.classe + " Lexema: " + token.lexema + " Tipo: Nulo\n" 
		break
	end

end

