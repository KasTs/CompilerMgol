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