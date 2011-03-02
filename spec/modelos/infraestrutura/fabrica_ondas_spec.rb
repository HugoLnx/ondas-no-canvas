require 'spec_helper'

module OndasNoCanvas
	module Modelos
		module Infra
			describe 'Uma Fabrica de Ondas' do
				it 'deveria ser instanciavel' do
					lambda{FabricaOndas.new}.should_not raise_error
				end
				
				context 'apos ser instanciada' do
					before :all do
						@fabrica = FabricaOndas.new
					end
					
					it 'deveria lancar uma excessao(OndaException) caso haja um erro na fabricacao da onda' do
						OndaException = Exception if OndaException.nil?
						lambda{@fabrica.fabrica_onda_com(:amplitude => '',
												  :lambda => '',
												  :velocidade => '',
												  :frequencia => '',
												  :periodo => ''
						)}.should raise_error OndaException
					end
					
					it 'deveria poder fabricar uma onda' do
						OndasNoCanvas::Modelos::Onda = mock(:onda_class) if OndasNoCanvas::Modelos::Onda.nil?
						onda_class = OndasNoCanvas::Modelos::Onda
						onda = mock :onda, :class => onda_class
						onda_class.stub!(:new).with(any_args).and_return(onda)
						@fabrica.fabrica_onda_com(:amplitude => '50',
												  :lambda => '20',
												  :velocidade => '200',
												  :frequencia => '',
												  :periodo => ''
						).should be_eql onda
					end
				end
			end
		end
	end
end
