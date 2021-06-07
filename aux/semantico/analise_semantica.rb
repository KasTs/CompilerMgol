def write_file()

    if (!@erro_analise)
        arquivo = File.new("programa.c", "w")
        arquivo.puts("#include<stdio.h>")
        arquivo.puts("typedef char literal[256];")
        arquivo.puts("void main(void) \n{")
        arquivo.puts("/*----Variaveis temporarias----*/")
        #imprimir var temporárias aqui
        arquivo.puts("/*------------------------------*/")

        puts "tamanho do arquivo": + @texto_programa.length.to_s
        
        @texto_programa.each do |linha|
            arquivo.puts(linha)
        end
        arquivo.puts("}")
        arquivo.close()
    end
end

def is_int(lexema)
    return Integer(lexema) && true rescue false
end

def is_float(lexema)
    return Float(lexema) && true rescue false
end

@contador_tx = 0

def analisador_semantico(num_regra,alpha,beta)

    topo_semantica = Token.new(alpha,alpha,nil)

    #faltam as regras 7,8

    #LV -> varfim;
    if num_regra == '5'
        @texto_programa.append("\n\n\n")
    #D -> TIPO L ;
    elsif num_regra == '6'
        @texto_programa.push(";")
    #L -> id
    elsif num_regra == '8'
        @texto_programa.push(beta[0].lexema)
    #TIPO -> int
    elsif num_regra == '9'
        topo_semantica.tipo = 'inteiro'
        #puts simbolo_reduzido.tipo.class
        @texto_programa.push(topo_semantica.tipo)
    #TIPO -> real
    elsif num_regra == '10'
        topo_semantica.tipo = 'real'
        @texto_programa.push(topo_semantica.tipo)
    #TIPO -> lit
    elsif num_regra == '11'
        topo_semantica.tipo = 'literal'
        @texto_programa.push(topo_semantica.tipo)
    #ES -> leia id ;
    elsif num_regra == '13'
        #se não houver tipo no ID, significa que não foi declarado
        if !beta[1].tipo
            puts "Erro: variável não declarada na linha #{@line-1} e coluna #{@column}." 
            @erro_analise = true
        elsif beta[1].tipo == "literal"
            @texto_programa.push("scanf(“%s”, #{beta[1].lexema});")
        elsif beta[1].tipo == "int"
            @texto_programa.push("scanf(“%d”, &#{beta[1].lexema});")
        elsif beta[2].tipo == "real"
            @texto_programa.push("scanf(“%lf”, &#{beta[1].lexema});")
        end
    #ES -> escreva ARG;
    elsif num_regra == '14'
        @texto_programa.push("printf(“#{beta[1].lexema}”);")
    #ARG -> literal
    elsif num_regra == '15'
        topo_semantica.classe = beta[0].classe
        topo_semantica.lexema = beta[0].lexema
        topo_semantica.tipo = beta[0].tipo
    #ARG -> num
    elsif num_regra == '16'
        topo_semantica.classe = beta[0].classe
        topo_semantica.lexema = beta[0].lexema
        topo_semantica.tipo = beta[0].tipo
    #ARG -> id
    elsif num_regra == '17'
        if !beta[0].tipo
            puts "Erro: variável não declarada na linha #{@line-1} e coluna #{@column}." 
            @erro_analise = true
        else
            topo_semantica.classe = beta[0].classe
            topo_semantica.lexema = beta[0].lexema
            topo_semantica.tipo = beta[0].tipo
        end
    #CMD -> id rcb LD;
    elsif num_regra == '19'
        if !beta[0].tipo
            puts "Erro: variável não declarada na linha #{@line-1} e coluna #{@column}." 
            @erro_analise = true
        else
            if beta[0].tipo != beta[2].tipo
                puts beta[0].tipo.to_s
                puts beta[2].tipo.to_s
                puts "Erro: tipos diferentes para atribuição na linha #{@line-1} e coluna #{@column}."
                @erro_analise = true
            else
                @texto_programa.push(beta[0].lexema + "=" + beta[2].lexema)
            end
        end
    # LD -> OPRD opm OPRD
    elsif num_regra == '20'
        puts beta[0].tipo.to_s
        puts beta[1].lexema.to_s
        puts beta[2].tipo.to_s
        if beta[0].tipo == beta[2].tipo and beta[0].tipo != "literal"
            topo_semantica.lexema = "T"+ @contador_tx.to_s
            topo_semantica.tipo = beta[0].tipo
            @texto_programa.push(topo_semantica.lexema + "=" + beta[0].lexema + beta[1].lexema + beta[2].lexema)
            @contador_tx+=1
        else
            puts "Erro: operandos com tipos incompativeis na linha #{@line-1} e coluna #{@column}"
            @erro_analise = true
        end
    #LD -> OPRD
    elsif num_regra == '21'
        topo_semantica.classe = beta[0].classe
        topo_semantica.lexema = beta[0].lexema
        topo_semantica.tipo = beta[0].tipo
    #OPRD -> id
    elsif num_regra == '22'
        if !beta[0].tipo
            puts "Erro: variável não declarada na linha #{@line-1} e coluna #{@column}." 
            @erro_analise = true
        else
            topo_semantica.classe = beta[0].classe
            topo_semantica.lexema = beta[0].lexema
            topo_semantica.tipo = beta[0].tipo
        end

    #OPRD -> num
    elsif num_regra == '23'
        puts beta[0].classe
        puts beta[0].lexema
        puts beta[0].tipo
        topo_semantica.classe = beta[0].classe
        topo_semantica.lexema = beta[0].lexema

        #extrai o tipo a partir do lexema do num
        if is_int(beta[0].lexema)
            tipo = "inteiro"
        elsif is_float(beta[0].lexema)
            tipo = "real"
        end
        topo_semantica.tipo = tipo

        puts topo_semantica.tipo.to_s
    #COND -> CAB CP
    elsif num_regra == '25'
        @texto_programa.push("}")
    #CAB -> se ( EXP_R ) então
    elsif num_regra == '26'
        exp_r = beta[2].lexema
        @texto_programa.push("if(#{exp_r}){")
    #EXP_R -> OPRD opr OPRD
    elsif num_regra == '27'
        if beta[0].tipo == beta[2].tipo
            topo_semantica.lexema = "T"+ @contador_tx.to_s
            @texto_programa.push(topo_semantica.lexema + "=" + beta[0].lexema + beta[1].lexema + beta[2].lexema)
        else
            puts "Erro: Operandos com tipos incompativeis na linha #{@line-1} e coluna #{@column}"
        end
    #R -> facaAte ( EXP_R ) CP_R
    elsif num_regra == '33'
        exp_r = beta[2].lexema
        @texto_programa.push("while(#{exp_r}){")
    elsif num_regra == '37'
        @texto_programa.push("}")
    end

    return topo_semantica
end