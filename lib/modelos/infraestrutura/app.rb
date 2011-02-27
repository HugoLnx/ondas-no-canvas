module OndasInCloud
  module Modelos
    module Infra
      module Application
        extend self
        def run
          include OndasInCloud::Controlador
        end
      end
    end
  end
end
