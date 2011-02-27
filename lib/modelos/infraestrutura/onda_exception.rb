module OndasInCloud
	module Modelos
		module Infra
			class OndaException < Exception
				def mensagem_notificacao
					case self.message
						when :FaltaDados then 'Dados insuficientes.'
						when :SemAmplitude then 'Informe o valor da Amplitude.'
						when :ComLetras then 'Preencha os campos somente com numeros.'
						when :FrequenciaPeriodoErro then 'A frequencia deve ser o inverso do periodo.'
						when :VelocidadeLambdaFrequenciaErro then 'A velocidade deve ser igual a lambda * frequencia.'
					end
				end
			end
		end
	end
end
