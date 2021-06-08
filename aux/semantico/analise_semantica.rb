def write_file()

    if (!@erro_analise)
        arquivo = File.new("programa.c", "w")
        arquivo.puts("#include<stdio.h>")
        arquivo.puts("typedef char literal[256];")
        arquivo.puts("void main(void) \n{")
        arquivo.puts("/*----Variaveis temporarias----*/")
        @variaveis_temporarias.each do |linha|
            arquivo.puts(linha)
        end
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

    #LV -> varfim;
    if num_regra == '5'
        @texto_programa.append("\n\n\n")
    #D -> TIPO L ;
    elsif num_regra == '6'
        #@texto_programa.append(beta[0].tipo + beta[1].lexema + ";")
        @texto_programa.append(";")
    #L -> id
    elsif num_regra == '8'
        #Impressão do lexema do id 
        id = beta[0]
        @texto_programa.append(id.lexema)
    #TIPO -> int
    elsif num_regra == '9'
        #TIPO.tipo -> inteiro.tipo
        topo_semantica.tipo = 'inteiro'
        @texto_programa.push(topo_semantica.tipo)
    #TIPO -> real
    elsif num_regra == '10'
        #TIPO.tipo -> real.tipo
        topo_semantica.tipo = 'real'
        @texto_programa.push(topo_semantica.tipo)
    #TIPO -> lit
    elsif num_regra == '11'
        #TIPO.tipo -> literal.tipo
        topo_semantica.tipo = 'literal'
        @texto_programa.push(topo_semantica.tipo)
    #ES -> leia id ;
    elsif num_regra == '13'
        id = beta[1]
        #se não houver tipo no ID, significa que não foi declarado
        if !id.tipo
            puts "Erro: variável não declarada na linha #{@line-1} e coluna #{@column}." 
            @erro_analise = true
        elsif id.tipo == "literal"
            @texto_programa.push("scanf(“%s”, #{id.lexema});")
        elsif id.tipo == "int"
            @texto_programa.push("scanf(“%d”, &#{id.lexema});")
        elsif id.tipo == "real"
            @texto_programa.push("scanf(“%lf”, &#{id.lexema});")
        end
    #ES -> escreva ARG;
    elsif num_regra == '14'
        arg = beta[1]
        @texto_programa.push("printf(“#{arg.lexema}”);")
    #ARG -> literal
    elsif num_regra == '15'
        #Copiar todos os atributos de literal para os atributos de ARG
        topo_semantica.classe = beta[0].classe
        topo_semantica.lexema = beta[0].lexema
        topo_semantica.tipo = beta[0].tipo
    #ARG -> num
    elsif num_regra == '16'
        #Copiar todos os atributos de num para os atributos de ARG
        topo_semantica.classe = beta[0].classe
        topo_semantica.lexema = beta[0].lexema
        topo_semantica.tipo = beta[0].tipo
    #ARG -> id
    elsif num_regra == '17'
        id = beta[0]
        #se não houver tipo no ID, significa que não foi declarado
        if !id.tipo
            puts "Erro: variável não declarada na linha #{@line-1} e coluna #{@column}." 
            @erro_analise = true
        else
            #Copiar todos os atributos de id para os atributos de ARG
            topo_semantica.classe = id.classe
            topo_semantica.lexema = id.lexema
            topo_semantica.tipo = id.tipo
        end
    #CMD -> id rcb LD;
    #atribuição
    elsif num_regra == '19'
        id = beta[0]
        ld = beta[2]
        if !id.tipo
            puts "Erro: variável não declarada na linha #{@line-1} e coluna #{@column}." 
            @erro_analise = true
        else
            if id.tipo != ld.tipo
                puts "Erro: tipos diferentes para atribuição na linha #{@line-1} e coluna #{@column}."
                @erro_analise = true
            else
                @texto_programa.push(id.lexema + "=" + ld.lexema)
            end
        end
    # LD -> OPRD opm OPRD
    #operação entre dois operandos
    elsif num_regra == '20'
        oprd1 = beta[0]
        oprd2 = beta[2]
        op = beta[1]
        if oprd1.tipo == oprd2.tipo and oprd1.tipo != "literal"
            #variável auxiliar
            topo_semantica.lexema = "T"+ @contador_tx.to_s
            topo_semantica.tipo = oprd1.tipo
            @texto_programa.push(topo_semantica.lexema + "=" + oprd1.lexema + op.lexema + oprd2.lexema)
            @variaveis_temporarias.push(oprd1.tipo + " " + topo_semantica.lexema + ";")
            @contador_tx+=1
        else
            puts "Erro: operandos com tipos incompativeis na linha #{@line-1} e coluna #{@column}"
            @erro_analise = true
        end
    #LD -> OPRD
    #Copiar todos os atributos de OPRD para os atributos de LD
    elsif num_regra == '21'
        oprd = beta[0]
        topo_semantica.classe = oprd.classe
        topo_semantica.lexema = oprd.lexema
        topo_semantica.tipo = oprd.tipo
    #OPRD -> id
    #Copiar todos os atributos de id para os atributos de OPRD
    elsif num_regra == '22'
        id = beta[0]
        if !id.tipo
            puts "Erro: variável não declarada na linha #{@line-1} e coluna #{@column}." 
            @erro_analise = true
        else
            topo_semantica.classe = id.classe
            topo_semantica.lexema = id.lexema
            topo_semantica.tipo = id.tipo
        end

    #OPRD -> num
    #Copiar todos os atributos de num para os atributos de OPRD
    elsif num_regra == '23'
        num = beta[0]
        topo_semantica.classe = num.classe
        topo_semantica.lexema = num.lexema

        #extrai o tipo a partir do lexema do num
        if is_int(num.lexema)
            tipo = "inteiro"
        elsif is_float(num.lexema)
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
    #expressão relacional
    elsif num_regra == '27'
        oprd1 = beta[0]
        oprd2 = beta[2]
        opr = beta[1]
        if oprd1.tipo == oprd2.tipo
            topo_semantica.lexema = "T"+ @contador_tx.to_s
            @texto_programa.push(topo_semantica.lexema + "=" + oprd1.lexema + opr.lexema + oprd2.lexema)
            @variaveis_temporarias.push(oprd1.tipo + " " +topo_semantica.lexema + ";")
            @contador_tx+=1
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