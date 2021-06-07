class Token

	def initialize(classe,lexema,tipo)
		@classe = classe
		@lexema = lexema
		@tipo = tipo
	end

	attr_accessor :classe
	attr_accessor :lexema
	attr_accessor :tipo
end