require_relative 'aux/lexico/afd'
require_relative 'aux/lexico/token_class'
require_relative 'aux/lexico/tabela_simbolos'
require_relative 'aux/lexico/analise_lexica'
require_relative 'aux/sintatico/actions'
require_relative 'aux/sintatico/goto'
require_relative 'aux/sintatico/regras_gramatica'
require_relative 'aux/semantico/analise_semantica'

@line = 1
@column = 0

@f = File.new("teste.txt")
@erro_analise = false
@texto_programa = []
@variaveis_temporarias = []

token = scanner()
a = token.classe
puts "token lido:" + token.classe + " - " + token.lexema 
pilha_sintatica = ["$","0"]
pilha_semantica = []
ps = []

loop do

	s = pilha_sintatica.last

	#tratamento de erro: modo pânico
	if !@actions[s][a]
		@erro_analise = true
		puts "Erro de sintaxe - token inesperado: \"#{token.lexema}\" na linha #{@line}, coluna #{@column}. Tokens esperados: #{@actions[s].keys}" 

		while !@actions[s][a] do
			if @f.eof?
				exit
			else 
				token = scanner()
				a = token.classe
			end
		end
		
		pilha_semantica.push(token)
		ps.push(a)
	#shift
	elsif @actions[s][a].start_with?("S")
		
		#puts "actions["+s+"]["+a+"] = " + @actions[s][a]
		#empilha t na pilha sintatica
		t = @actions[s][a].delete_prefix("S")		
		pilha_sintatica.push(t)

		pilha_semantica.push(token)
		ps.push(a)

		if t == '20'
			#sequencia na pilha: TIPO,id
			#Ajustar a passagem do atributo de TIPO.tipo para o atributo tipo dos id(s)
			tipo = pilha_semantica[-1]
			id = pilha_semantica[-2]
			tipo.tipo = id.tipo
		end

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

			#if valid_token
			#	puts "token lido:" + token.classe + " - " + token.lexema
			#end

			break if valid_token
		end

		#puts "pilha sintática:" + pilha_sintatica.to_s
		#puts "pilha semantica:" + ps.to_s

	#redução
	elsif @actions[s][a].start_with?("R")
		puts "actions["+s+"]["+a+"] = " + @actions[s][a]	
		num_regra = @actions[s][a].delete_prefix("R")
		regra = @gram[num_regra.to_i]

		#desempilha |b| simbolos
		tam_beta = regra.split("→")[1].split(" ").size
		pilha_sintatica.pop(tam_beta)
		
		#empilha GOTO[t][A]
		t = pilha_sintatica.last
		alpha = regra.split("→")[0]
		pilha_sintatica.push(@goto[t][alpha])
		
		puts "goto["+t+"]["+alpha+"] = " + @goto[t][alpha]
		
		puts regra
		
		#puts "pilha sintática:" + pilha_sintatica.to_s
		puts "pilha semantica:" + ps.to_s
		
		#ANALISADOR SEMÂNTICO
		beta = pilha_semantica.pop(tam_beta)
		ps.pop(tam_beta)
		#analise_semantica retorna o novo topo da pilha semantica - isto é, o símbolo que foi reduzido
		novo_topo_ps =  analisador_semantico(num_regra,alpha,beta)
		pilha_semantica.push(novo_topo_ps)
		ps.push(novo_topo_ps.classe)
		
		puts "pilha semantica apos a reducao:" + ps.to_s

	elsif @actions[s][a] == "ACC"
		puts "P' -> P"
		break		
	end
	puts "------------"
end

write_file()