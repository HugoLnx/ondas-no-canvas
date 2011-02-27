module OndasInCloud
	module Modelos
		class Onda
			def initialize(dados={})
				encontrado_dado_com_letras = dados.values.any?{|dado| dado.is_a?(String) && dado.match(/[^0-9.]/)}
				raise Infra::OndaException, :ComLetras if encontrado_dado_com_letras
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
				raise Infra::OndaException,:SemAmplitude if dados[:amplitude].nil?
				raise Infra::OndaException,:FaltaDados if num_dados < 2
			end
		
			def calcula_propriedades
				@frequencia = 1/@periodo if !@periodo.nil? and @frequencia.nil?
				@frequencia = @velocidade/@lambda if @frequencia.nil?
				@velocidade = @lambda*@frequencia if @velocidade.nil?
				@lambda = @velocidade / @frequencia if @lambda.nil?
				@periodo = 1/@frequencia if @periodo.nil?
			end
		
			def checa_vericidade_dos_valores
				raise Infra::OndaException, :FrequenciaPeriodoErro if @frequencia.eh_diferente? 1/@periodo
				raise Infra::OndaException, :VelocidadeLambdaFrequenciaErro if @velocidade.eh_diferente? @lambda * @frequencia
			end
		
			def propriedades
				{:amplitude => @amplitude,
				 :lambda => @lambda,
				 :velocidade => @velocidade,
				 :frequencia => @frequencia,
				 :periodo => @periodo}
			end
		
			def y_quando(args={})
				x = args[:x]
				tempo = args[:tempo]
				pi = Math::PI
				@amplitude * Math.sin((2*pi*(x-tempo*@velocidade)).to_f/@lambda)
			end
			
			def gerar_ys(args={})
				tempo = args[:tempo]
				x_max = args[:x_max]
				ys = []
				x_max.times do |x|
					ys << y_quando(:tempo => tempo, :x => x)
				end
				ys
			end
		end
	end
end
