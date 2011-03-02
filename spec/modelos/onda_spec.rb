require 'spec_helper'

module OndasNoCanvas
	module Modelos
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
          @onda.instance_variable_get(:@amplitude).should_not be_nil
        end
    
        it 'deveria ter lambda' do
          @onda.instance_variable_get(:@lambda).should_not be_nil
        end
    
        it 'deveria ter velocidade' do
          @onda.instance_variable_get(:@velocidade).should_not be_nil
        end
    
        it 'deveria ter frequencia' do
          @onda.instance_variable_get(:@frequencia).should_not be_nil
        end
    
        it 'deveria ter periodo' do
          @onda.instance_variable_get(:@periodo).should_not be_nil
        end
        
        it 'deveria retornar uma hash com suas propriedades' do
          @onda.propriedades.should be_eql(:amplitude => 50.0,
                           :lambda => 20.0,
                           :velocidade => 200.0,
                           :frequencia => 10.0,
                           :periodo => 0.1)
        end
        
        it 'deveria retornar a coordenada y de um ponto de acordo com o x e o tempo' do
          amplitude = @onda.instance_variable_get(:@amplitude)
          velocidade = @onda.instance_variable_get(:@velocidade)
          lambda = @onda.instance_variable_get(:@lambda)
          pi = Math::PI
          tempo = rand(100)
          x = rand(100)
          y = @onda.y_quando(:tempo => tempo,
                             :x => x)
          y.should be_eql amplitude * Math.sin((2*pi*(x-tempo*velocidade)).to_f/lambda)
        end
        
        it 'deveria gerar as suas coordenadas y de um tempo' do
          tempo = rand(100)
          x_max = 100
          ys = @onda.gerar_ys(:tempo => tempo,
                              :x_max => x_max)
          ys.each_with_index do |y,x|
            y.should be_eql @onda.y_quando(:tempo => tempo,:x => x)
          end
        end


        it 'deveria gerar as suas coordenadas y de todos os tempos necessarios para gerar a animacao' do
          delay = 100
          x_max = 100
          ys = @onda.gerar_todos_os_ys(:delay => 100,
                                       :x_max => x_max)
          ys.each_with_index do |ys_de_agora,frame|
            tempo = frame * delay/1000.0
            ys_de_agora.should be_eql @onda.gerar_ys(:tempo => tempo,:x_max => x_max)
          end
        end
      end
  
      context 'apos ser instanciada passando lambda = 20 e frequencia = 10' do
        before do
          @onda = Onda.new :amplitude => 50,
                   :lambda => 20,
                   :frequencia => 10
        end
    
        it 'deveria ter velocidade igual a 200' do
          @onda.propriedades[:velocidade].should be_eql 200.0
        end
    
        it 'deveria ter periodo igual a 0.1' do
          @onda.propriedades[:periodo].should be_eql 0.1
        end
      end
  
      context 'apos ser instanciada passando velocidade = 200 e frequencia = 10' do
        before do
          @onda = Onda.new :amplitude => 50,
                   :velocidade => 200,
                   :frequencia => 10
        end
    
        it 'deveria ter lambda igual a 20' do
          @onda.propriedades[:lambda].should be_eql 20.0
        end
    
        it 'deveria ter periodo igual a 0.1' do
          @onda.propriedades[:periodo].should be_eql 0.1
        end
      end
  
      context 'apos ser instanciada passando lambda = 20 e periodo = 0.1' do
        before do
          @onda = Onda.new :amplitude => 50,
                   :lambda => 20,
                   :periodo => 0.1
        end
    
        it 'deveria ter velocidade igual a 200' do
          @onda.propriedades[:velocidade].should be_eql 200.0
        end
    
        it 'deveria ter frequencia igual a 10' do
          @onda.propriedades[:frequencia].should be_eql 10.0
        end
      end
  
      context 'apos ser instanciada passando velocidade = 200 e periodo = 0.1' do
        before do
          @onda = Onda.new :amplitude => 50,
                   :velocidade => 200.0,
                   :periodo => 0.1
        end
    
        it 'deveria ter lambda igual a 20' do
          @onda.propriedades[:lambda].should be_eql 20.0
        end
    
        it 'deveria ter frequencia igual a 10' do
          @onda.propriedades[:frequencia].should be_eql 10.0
        end
      end
  
      context 'apos ser instanciada passando velocidade = 200 e lambda = 20' do
        before do
          @onda = Onda.new :amplitude => 50,
                   :velocidade => 200,
                   :lambda => 20
        end
    
        it 'deveria ter frequencia igual a 10' do
          @onda.propriedades[:frequencia].should be_eql 10.0
        end
    
        it 'deveria ter periodo igual a 0.1' do
          @onda.propriedades[:periodo].should be_eql 0.1
        end
      end
  
      it 'deveria lancar uma OndaException com a mensagem :FaltaDados ao ser instanciada passando a amplitude e o lambda' do
        lambda{@onda = Onda.new :amplitude => 50, 
                    :lambda => 20
        }.should raise_error Infra::OndaException,:FaltaDados
      end
  
      it 'deveria lancar uma OndaException com a mensagem :FaltaDados ao ser instanciada passando a amplitude e a velocidade' do
        lambda{@onda = Onda.new :amplitude => 50, 
                    :velocidade => 200
        }.should raise_error Infra::OndaException,:FaltaDados
      end
  
      it 'deveria lancar uma OndaException com a mensagem :FaltaDados ao ser instanciada passando a amplitude e a frequencia' do
        lambda{@onda = Onda.new :amplitude => 50, 
                    :frequencia => 10
        }.should raise_error Infra::OndaException,:FaltaDados
      end
  
      it 'deveria lancar uma OndaException com a mensagem :FaltaDados ao ser instanciada passando a amplitude e o periodo' do
        lambda{@onda = Onda.new :amplitude => 50, 
                    :periodo => 0.1
        }.should raise_error Infra::OndaException,:FaltaDados
      end
  
      it 'deveria lancar uma OndaException com a mensagem :FaltaDados ao ser instanciada passando a amplitude, a frequencia e o periodo' do
        lambda{@onda = Onda.new :amplitude => 50, 
                    :frequencia => 10, 
                    :periodo => 0.1
        }.should raise_error Infra::OndaException,:FaltaDados
      end
  
      it 'deveria lancar uma OndaException com a mensagem :SemAmplitude ao ser instanciada sem passar nada' do
        lambda{@onda = Onda.new}.should raise_error Infra::OndaException,:SemAmplitude
      end
  
      it 'deveria lancar uma OndaException com a mensagem :SemAmplitude ao ser instanciada sem passar a amplitude' do
        lambda{@onda = Onda.new :lambda => 20, 
                    :velocidade => 200,
                    :frequencia => 10,
                    :periodo => 0.1
        }.should raise_error Infra::OndaException,:SemAmplitude
      end
  
      it 'deveria lancar uma OndaException com a mensagem :ComLetras ao ser instanciada passando o lambda com letras' do
        lambda{@onda = Onda.new	:lambda => '20as'
        }.should raise_error Infra::OndaException,:ComLetras
      end
  
      it 'deveria lancar uma OndaException com a mensagem :ComLetras ao ser instanciada passando a velocidade com letras' do
        lambda{@onda = Onda.new :velocidade => '200asdf'
        }.should raise_error Infra::OndaException,:ComLetras
      end
  
      it 'deveria lancar uma OndaException com a mensagem :ComLetras ao ser instanciada passando a frequencia com letras' do
        lambda{@onda = Onda.new :frequencia => '10asd'
        }.should raise_error Infra::OndaException,:ComLetras
      end
  
      it 'deveria lancar uma OndaException com a mensagem :ComLetras ao ser instanciada passando o periodo com letras' do
        lambda{@onda = Onda.new :periodo => '0.asdf1'
        }.should raise_error Infra::OndaException,:ComLetras
      end
  
      it 'deveria lancar uma OndaException com a mensagem :FrequenciaPeriodoErro ao ser instanciada passando frequencia e periodo invalidos' do
        lambda{@onda = Onda.new :amplitude => 50,
                    :lambda => 20, 
                    :velocidade => 200,
                    :frequencia => 10,
                    :periodo => 1234
        }.should raise_error Infra::OndaException, :FrequenciaPeriodoErro
      end
  
      it 'deveria lancar uma OndaException com a mensagem :VelocidadeLambdaFrequenciaErro ao ser instanciada passando velocidade, lambda e frequencia invalidos' do
        lambda{@onda = Onda.new :amplitude => 50,
                    :lambda => 20, 
                    :velocidade => 999,
                    :frequencia => 10,
                    :periodo => 0.1
        }.should raise_error Infra::OndaException, :VelocidadeLambdaFrequenciaErro
      end
    end
  end
end
