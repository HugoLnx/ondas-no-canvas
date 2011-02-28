module OndasNoCanvas
  module Modelos
    module Infra
      module Application
        extend self
        def run
          include OndasNoCanvas::Controlador
        end
      end
    end
  end
end
