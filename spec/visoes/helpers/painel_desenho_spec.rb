require 'spec_helper'

module Ondas2
	module Visoes
		module Helpers
		
		
			describe PainelDesenho do
				it 'deveria herdar de um JPanel' do
					PainelDesenho.superclass.should be JPanel
				end
	
				it 'deveria ser instanciavel' do
					lambda{PainelDesenho.new}.should_not raise_error
				end
			end
			
		end
	end
end
