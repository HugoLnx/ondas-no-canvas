module Ondas2
	class Aplicacao
		attr_reader :componentes
		attr_reader :janela
		attr_reader :onda
		def initialize
			@componentes = Componentes.new
		end
	
		def inicia(args={})
			em_teste = args[:teste]
		
			@janela = self.usa(:classe => Janela, 
							   :args => [{:app_mae => self, 
										 :titulo => 'Visualizador de Ondas'}])
			cria_e_posiciona_outros_componentes
			observador = ObservadorEventos.new self
			@janela.visible = true unless em_teste
		end
		
		def cria_e_posiciona_outros_componentes
			jmenu_bar = JMenuBar.new#self.usa :classe => JMenuBar, :nome => 'barra_menu'
			jmenu_arq = JMenu.new 'Arquivo'
			jmenu_salvar_item = JMenuItem.new 'Salvar como...'
			jmenu_visu_item = JMenuItem.new 'Visualizacao Externa'
			jmenu_sair_item = JMenuItem.new 'Sair'
			jmenu_arq.add jmenu_salvar_item
			jmenu_arq.add jmenu_visu_item
			jmenu_arq.add jmenu_sair_item
			jmenu_about = JMenu.new 'About'
			jmenu_ondas_item = JMenuItem.new 'Ondas 2.0'
			jmenu_autor_item = JMenuItem.new 'Autor'
			jmenu_about.add jmenu_ondas_item
			jmenu_about.add jmenu_autor_item
			jmenu_bar.add jmenu_arq
			jmenu_bar.add jmenu_about
			@janela.setJMenuBar(jmenu_bar)
			
			lbl_des_onda = self.usa :classe => JLabel, :args => 'Desenho da Onda'
			
			pnl_des = self.usa :classe =>  PainelDesenho, :nome => 'desenho'
			pnl_des.janela_mae = self.janela
			thread = JThread.new pnl_des
			thread.start
			
			pnl_des.background = Color::WHITE
			pnl_des.border = BorderFactory.create_line_border(Color::BLACK)
			
			lbl_amp = self.usa :classe => JLabel, :args => 'Amplitude'
			lbl_lam = self.usa :classe => JLabel, :args => 'Lambda'
			lbl_vel = self.usa :classe => JLabel, :args => 'Velocidade'
			lbl_freq = self.usa :classe => JLabel, :args => 'Frequencia'
			lbl_per = self.usa :classe => JLabel, :args => 'Periodo'
			
			lbl_erros = self.usa :classe => JLabel, :args => 'erros'
			lbl_erros.text = ' '
			lbl_erros.foreground = Color::RED
			
			txtf_amp = self.usa :classe => JTextField, :nome => 'amplitude'
			txtf_lam = self.usa :classe => JTextField, :nome => 'lambda'
			txtf_vel = self.usa :classe => JTextField, :nome => 'velocidade'
			txtf_freq = self.usa :classe => JTextField, :nome => 'frequencia'
			txtf_per = self.usa :classe => JTextField, :nome => 'periodo'
			
			btn_gerar = self.usa :classe => JButton, :args => 'Gerar Onda'
					
			pane = @janela.content_pane
			pane.add lbl_des_onda, BorderLayout::NORTH
			pane.add pnl_des, BorderLayout::CENTER
			pane.border = BorderFactory.create_empty_border(6,6,6,6)
			
			form = Container.new
			form.layout = GridBagLayout.new
			
			gbc = GridBagConstraints.new
			
			gbc.gridx = 0
			gbc.gridy = 0
			gbc.gridwidth = 2
			gbc.gridheight = 1
			gbc.fill = GridBagConstraints::HORIZONTAL
			gbc.weightx = 1
			form.add lbl_erros, gbc
			
			gbc.gridwidth = 1
			gbc.gridy +=1
			form.add lbl_amp, gbc
			
			gbc.gridy +=1
			form.add txtf_amp, gbc
			
			gbc.gridy +=1
			form.add lbl_lam, gbc
			
			gbc.gridy +=1
			form.add txtf_lam, gbc
			
			gbc.gridy +=1
			form.add lbl_vel, gbc
			
			gbc.gridy +=1
			form.add txtf_vel, gbc
			
			gbc.gridy = 1
			gbc.gridx += 1
			form.add lbl_freq, gbc
			
			gbc.gridy +=1
			form.add txtf_freq, gbc
			
			gbc.gridy += 1
			form.add lbl_per, gbc
			
			gbc.gridy +=1
			form.add txtf_per, gbc
			
			gbc.gridy +=2
			gbc.gridheight = 1
			gbc.fill = GridBagConstraints::BOTH
			gbc.ipady = -10
			form.add btn_gerar, gbc
			
			pane.add form, BorderLayout::SOUTH
		end
		
		def usa(args={})
			classe = args[:classe]
			nome = args[:nome]
			args_construtor = args[:args]
			
			comp = classe.method(:new).call(*args_construtor)
			
			nome = comp.text if nome.nil? and (comp.kind_of? JButton or comp.kind_of? JLabel)
			nome = comp.title if comp.kind_of? JFrame and nome.nil?
			
			self.componentes.adiciona comp, nome
			comp
		end
		
		def gera_onda
			txtfs = {:amplitude => self.componentes.o_de_classe_e_nome(JTextField, 'amplitude'),
					 :lambda => self.componentes.o_de_classe_e_nome(JTextField, 'lambda'),
					 :velocidade => self.componentes.o_de_classe_e_nome(JTextField, 'velocidade'),
					 :frequencia => self.componentes.o_de_classe_e_nome(JTextField, 'frequencia'),
					 :periodo => self.componentes.o_de_classe_e_nome(JTextField, 'periodo')}
			
			amp_val = txtfs[:amplitude].text.empty? ? nil : txtfs[:amplitude].text
			lam_val = txtfs[:lambda].text.empty? ? nil : txtfs[:lambda].text
			vel_val = txtfs[:velocidade].text.empty? ? nil : txtfs[:velocidade].text
			freq_val = txtfs[:frequencia].text.empty? ? nil : txtfs[:frequencia].text
			per_val = txtfs[:periodo].text.empty? ? nil : txtfs[:periodo].text
			begin
				lbl_erros = self.componentes.o_de_classe_e_nome JLabel, 'erros'
				@onda = Onda.new :amplitude => amp_val,
								 :lambda => lam_val,
								 :velocidade => vel_val,
								 :frequencia => freq_val,
								 :periodo => per_val
				lbl_erros.text = ' '
			rescue OndaException => e
				case e.message
				when :FaltaDados
					lbl_erros.text = 'Dados insuficientes.'
				when :SemAmplitude
					lbl_erros.text = 'Informe o valor da Amplitude.'
				when :ComLetras
					lbl_erros.text = 'Preencha os campos somente com numeros.'
				when :FrequenciaPeriodoErro
					lbl_erros.text = 'A frequencia deve ser o inverso do periodo.'
				when :VelocidadeLambdaFrequenciaErro
					lbl_erros.text = 'A velocidade deve ser igual a lambda * frequencia.'
				end
				return
			end
			
			txtfs.each_pair do |nome,txtf|
				txtf.text = @onda.method(nome).call.to_s if txtf.text.empty?
			end
		end
	end
end


=begin
		def cria_e_posiciona_outros_componentes
			lbl_des_onda = self.usa :classe => JLabel, :args => 'Desenho da Onda'
			pnl_des = self.usa :classe => JPanel, :nome => 'desenho'
			pnl_des.background = Color::WHITE
			pnl_des.border = BorderFactory.create_line_border(Color::BLACK)
			
			lbl_amp = self.usa :classe => JLabel, :args => 'Amplitude'
			lbl_lam = self.usa :classe => JLabel, :args => 'Lambda'
			lbl_vel = self.usa :classe => JLabel, :args => 'Velocidade'
			lbl_freq = self.usa :classe => JLabel, :args => 'Frequencia'
			lbl_per = self.usa :classe => JLabel, :args => 'Periodo'
			
			txtf_amp = self.usa :classe => JTextField, :nome => 'amplitude'
			txtf_lam = self.usa :classe => JTextField, :nome => 'lambda'
			txtf_vel = self.usa :classe => JTextField, :nome => 'velocidade'
			txtf_freq = self.usa :classe => JTextField, :nome => 'frequencia'
			txtf_per = self.usa :classe => JTextField, :nome => 'periodo'
			
			btn_gerar = self.usa :classe => JButton, :args => 'Gerar Onda'
								
			lbl_des_onda.set_bounds(10 , 10 , 275, 14)
			pnl_des.set_bounds	   (10 , 30 , 275, 120)
			lbl_amp.set_bounds	   (10 , 170, 70 , 14)
			txtf_amp.set_bounds	   (80 , 170, 59 , 20)
			lbl_lam.set_bounds	   (10 , 190, 70 , 14)
			txtf_lam.set_bounds	   (80 , 190, 59 , 20)
			lbl_vel.set_bounds	   (10 , 210, 70 , 14)
			txtf_vel.set_bounds	   (80 , 210, 59 , 20)
			lbl_freq.set_bounds	   (150, 170, 70 , 14)
			txtf_freq.set_bounds   (220, 170, 59 , 20)
			lbl_per.set_bounds	   (150, 190, 70 , 14)
			txtf_per.set_bounds	   (220, 190, 59 , 20)
			btn_gerar.set_bounds   (150, 210, 128, 19)
		end
		
		def usa(args={})
			classe = args[:classe]
			nome = args[:nome]
			args_construtor = args[:args]
			
			comp = classe.method(:new).call(*args_construtor)
			
			nome = comp.text if nome.nil? and (comp.kind_of? JButton or comp.kind_of? JLabel)
			nome = comp.title if comp.kind_of? JFrame and nome.nil?
			
			self.componentes.adiciona comp, nome
			@janela.content_pane.add comp if comp.kind_of? JFrame and !@janela.nil?
			comp
		end
=end
