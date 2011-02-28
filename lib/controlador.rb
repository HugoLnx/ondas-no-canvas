module OndasNoCanvas
  module Controlador
    get '/' do
      haml :index
    end
  
    post '/gera_onda' do
      onda = OndasNoCanvas::Modelos::Onda.new params
      @delay = 10
      @ys = onda.gerar_todos_os_ys :delay => @delay,
                                   :x_max => 500
      erb :gera_onda_js
    end
  end
end
