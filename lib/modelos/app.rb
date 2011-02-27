module Ondas2
  class App
    def call(env)
      [200,{"Content-Type" => "text/plain"},["Ola mundo"]]
    end
  end
end
