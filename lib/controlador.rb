module OndasInCloud
  module Controlador
    get '/' do
      haml :index
    end
  
    post '/gera_onda' do
      #onda_args = {}
      #params.each{|key,value| onda.merge!({key.to_sym => value})}
      p params
      onda = OndasInCloud::Modelos::Onda.new params
      @ys = onda.gerar_ys :tempo => 0.0,
                          :x_max => 500
      javascript =  erb :gera_onda_js
      puts javascript
      javascript
    end
  end
end
