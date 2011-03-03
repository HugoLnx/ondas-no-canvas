module OndasNoCanvas
  module Controlador
    get '/' do
      haml :index
    end
  
    post '/gera_onda' do
      begin
        onda = OndasNoCanvas::Modelos::Onda.new params
        @delay = 10
        @ys = onda.gerar_todos_os_ys :delay => @delay,
                                     :x_max => 500
        erb :'gera_onda.js'
      rescue OndasNoCanvas::Modelos::Infra::OndaException => exception
        @mensagem_de_erro = exception.mensagem_notificacao
        erb :'mostrar_erro.js'
      end
    end
  end
end
