require 'spec_helper'

module Ondas2
	module Modelos
		module InfraE
		
		
			describe 'Aplicacao' do
				it 'deveria ser instanciavel' do
					lambda{Aplicacao.new}.should_not raise_error
				end
		
				context 'apos ser instanciada' do
					before do
						@app = Aplicacao.new
					end
			
					it 'deveria ter componentes' do
						@app.componentes.should_not be_nil
					end

					it 'deveria poder utilizar qualquer componente do swing' do
						lambda{@app.usa :classe => JFrame,
								 :nome => :janela_principal,
								 :args => ['Nome Janela']}.should_not raise_error
					end
			
					context 'apos adicionar um componente do swing' do
						before do
							@app.usa :classe => JFrame,
									 :nome => :janela_principal,
									 :args => ['Nome Janela']
						end
				
						it 'o componente adicionado deve estar dentre os componentes da aplicacao' do
							comp = @app.componentes.o_de_classe_e_nome 'JFrame', :janela_principal 
							comp.should be_a JFrame
						end
					end
			
					context 'apos adicionar uma JLabel nao indicando o nome' do
						before do
							@comp = @app.usa :classe => JLabel,
											 :args => ['Nome Label']
						end
				
						it 'o componente deveria ter o nome igual ao seu conteudo textual' do
							comp = @app.componentes.o_de_classe_e_nome 'JLabel', @comp.text
							comp.should_not be_nil
						end
					end
			
					context 'apos adicionar um JButton nao indicando o nome' do
						before do
							@comp = @app.usa :classe => JButton,
											 :args => ['Nome Botao']
						end
				
						it 'o componente deveria ter o nome igual ao seu conteudo textual' do
							comp = @app.componentes.o_de_classe_e_nome 'JButton', @comp.text
							comp.should_not be_nil
						end
					end
			
					context 'apos adicionar um JFrame nao indicando o nome' do
						before do
							@comp = @app.usa :classe => JFrame,
											 :args => ['Nome Frame']
						end
				
						it 'o componente deveria ter o nome igual ao seu titulo' do
							comp = @app.componentes.o_de_classe_e_nome 'JFrame', @comp.title
							comp.should_not be_nil
						end
					end
			
					it 'deveria ser iniciavel' do
						lambda{@app.inicia}.should_not raise_error
					end
			
					context 'apos ser iniciada' do
						before do
							@app.inicia
						end
				
						it 'deveria ter uma janela' do
							@app.janela.should_not be_nil
						end
				
						it 'deveria ter uma janela visivel' do
							@app.janela.should be_visible
						end
					end
			
					it 'deveria poder ser iniciada em modo de teste' do
						lambda{@app.inicia :teste => true}.should_not raise_error
					end
			
					context 'apos ser iniciada' do
						before do
							@app.inicia :teste => true
						end
				
						it 'deveria ter uma janela' do
							@app.janela.should_not be_nil
						end
				
						it 'deveria ter uma janela invisivel' do
							@app.janela.should_not be_visible
						end
					end
				end
			end
			
			
		end
	end
end