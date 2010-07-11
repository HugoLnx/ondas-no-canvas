require 'spec_helper'

module Ondas2
	describe Onda do
		it 'deveria ser instanciavel' do
			lambda{
				Onda.new :amplitude => 50,
						 :lambda => 20,
						 :velocidade => 200,
						 :frequencia => 10,
						 :periodo => 0.1
			}.should_not raise_error
		end
		
		context 'apos ser instanciada passando todos os campos' do
			before do
				@onda = Onda.new :amplitude => 50,
								 :lambda => 20,
								 :velocidade => 200,
								 :frequencia => 10,
								 :periodo => 0.1
			end
		
			it 'deveria ter amplitude' do
				@onda.amplitude.should_not be_nil
			end
			
			it 'deveria ter lambda' do
				@onda.lambda.should_not be_nil
			end
			
			it 'deveria ter velocidade' do
				@onda.velocidade.should_not be_nil
			end
			
			it 'deveria ter frequencia' do
				@onda.frequencia.should_not be_nil
			end
			
			it 'deveria ter periodo' do
				@onda.periodo.should_not be_nil
			end
		end
		
		context 'apos ser instanciada passando lambda = 20 e frequencia = 10' do
			before do
				@onda = Onda.new :amplitude => 50,
								 :lambda => 20,
								 :frequencia => 10
			end
			
			it 'deveria ter velocidade igual a 200' do
				@onda.velocidade.should be_eql 200.0
			end
			
			it 'deveria ter periodo igual a 0.1' do
				@onda.periodo.should be_eql 0.1
			end
		end
		
		context 'apos ser instanciada passando velocidade = 200 e frequencia = 10' do
			before do
				@onda = Onda.new :amplitude => 50,
								 :velocidade => 200,
								 :frequencia => 10
			end
			
			it 'deveria ter lambda igual a 20' do
				@onda.lambda.should be_eql 20.0
			end
			
			it 'deveria ter periodo igual a 0.1' do
				@onda.periodo.should be_eql 0.1
			end
		end
		
		context 'apos ser instanciada passando lambda = 20 e periodo = 0.1' do
			before do
				@onda = Onda.new :amplitude => 50,
								 :lambda => 20,
								 :periodo => 0.1
			end
			
			it 'deveria ter velocidade igual a 200' do
				@onda.velocidade.should be_eql 200.0
			end
			
			it 'deveria ter frequencia igual a 10' do
				@onda.frequencia.should be_eql 10.0
			end
		end
		
		context 'apos ser instanciada passando velocidade = 200 e periodo = 0.1' do
			before do
				@onda = Onda.new :amplitude => 50,
								 :velocidade => 200.0,
								 :periodo => 0.1
			end
			
			it 'deveria ter lambda igual a 20' do
				@onda.lambda.should be_eql 20.0
			end
			
			it 'deveria ter frequencia igual a 10' do
				@onda.frequencia.should be_eql 10.0
			end
		end
		
		context 'apos ser instanciada passando velocidade = 200 e lambda = 20' do
			before do
				@onda = Onda.new :amplitude => 50,
								 :velocidade => 200,
								 :lambda => 20
			end
			
			it 'deveria ter frequencia igual a 10' do
				@onda.frequencia.should be_eql 10.0
			end
			
			it 'deveria ter periodo igual a 0.1' do
				@onda.periodo.should be_eql 0.1
			end
		end
		
		it 'deveria lacar uma excessao ao ser instanciada sem passar nada' do
			lambda{@onda = Onda.new}.should raise_error OndaException,:FaltaDados
		end
	end
end