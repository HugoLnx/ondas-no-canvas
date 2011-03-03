require 'spec_helper'

module OndasNoCanvas
	module Modelos
		module Infra
			describe 'OndaException' do
				context 'ao ser ativada com a mensagem :FaltaDados' do
					before :all do
						@erro = OndaException.new :FaltaDados
					end
					
					it 'deveria poder retornar uma mensagem de notificacao adequada' do
						@erro.mensagem_notificacao.should be_eql 'Dados insuficientes.'
					end
				end
				
				context 'ao ser ativada com a mensagem :SemAmplitude' do
					before :all do
						@erro = OndaException.new :SemAmplitude
					end
					
					it 'deveria poder retornar uma mensagem de notificacao adequada' do
						@erro.mensagem_notificacao.should be_eql 'Informe o valor da Amplitude.'
					end
				end
				
				context 'ao ser ativada com a mensagem :ComLetras' do
					before :all do
						@erro = OndaException.new :ComLetras
					end
					
					it 'deveria poder retornar uma mensagem de notificacao adequada' do
						@erro.mensagem_notificacao.should be_eql 'Preencha os campos somente com numeros.'
					end
				end
				
				context 'ao ser ativada com a mensagem :FrequenciaPeriodoErro' do
					before :all do
						@erro = OndaException.new :FrequenciaPeriodoErro
					end
					
					it 'deveria poder retornar uma mensagem de notificacao adequada' do
						@erro.mensagem_notificacao.should be_eql 'A frequencia deve ser o inverso do periodo.'
					end
				end
				
				context 'ao ser ativada com a mensagem :VelocidadeLambdaFrequenciaErro' do
					before :all do
						@erro = OndaException.new :VelocidadeLambdaFrequenciaErro
					end
					
					it 'deveria poder retornar uma mensagem de notificacao adequada' do
						@erro.mensagem_notificacao.should be_eql 'A velocidade deve ser igual a lambda * frequencia.'
					end
				end

				context 'ao ser ativada com a mensagem :CampoZerado' do
					before :all do
						@erro = OndaException.new :CampoZerado
					end
					
					it 'deveria poder retornar uma mensagem de notificacao adequada' do
						@erro.mensagem_notificacao.should be_eql 'Somente a amplitude pode ter valor igual a 0.'
					end
				end
			end
		end
	end
end
