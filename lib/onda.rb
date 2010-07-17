module Ondas2
	class Onda
		attr_reader :amplitude,:lambda,:velocidade,:frequencia,:periodo
		def initialize(dados={})
			encontrado_dado_com_letras = dados.values.any?{|dado| dado.is_a?(String) && dado.match(/[^0-9.]/)}
			raise OndaException, :ComLetras if encontrado_dado_com_letras
			inicializa_atributos_com dados
			checa_se_e_possivel_definir_a_onda_com_os dados
			calcula_propriedades
			checa_vericidade_dos_valores
		end
		
		def inicializa_atributos_com(dados)
			@amplitude = dados[:amplitude].to_f unless dados[:amplitude].nil?
			@lambda = dados[:lambda].to_f unless dados[:lambda].nil?
			@velocidade = dados[:velocidade].to_f unless dados[:velocidade].nil?
			@frequencia = dados[:frequencia].to_f unless dados[:frequencia].nil?
			@periodo = dados[:periodo].to_f unless dados[:periodo].nil?
		end
		
		def checa_se_e_possivel_definir_a_onda_com_os(dados)
			num_dados = 0
			num_dados += 1 if !dados[:velocidade].nil?
			num_dados += 1 if !dados[:lambda].nil?
			num_dados += 1 if !dados[:frequencia].nil? or !dados[:periodo].nil?
			raise OndaException,:SemAmplitude if dados[:amplitude].nil?
			raise OndaException,:FaltaDados if num_dados < 2
		end
		
		def calcula_propriedades
			@frequencia = 1/@periodo if !@periodo.nil? and @frequencia.nil?
			@frequencia = @velocidade/@lambda if @frequencia.nil?
			@velocidade = @lambda*@frequencia if @velocidade.nil?
			@lambda = @velocidade / @frequencia if @lambda.nil?
			@periodo = 1/@frequencia if @periodo.nil?
		end
		
		def checa_vericidade_dos_valores
			raise OndaException, :FrequenciaPeriodoErro if @frequencia != 1/@periodo
			raise OndaException, :VelocidadeLambdaFrequenciaErro if @velocidade != @lambda * @frequencia
		end
	end
end
