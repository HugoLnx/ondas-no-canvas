module OndasInCloud
  module Infra
    class App
      def call(env)
        [200,{"Content-Type" => "text/plain"},["Ola mundo"]]
      end
    end
  end
end
