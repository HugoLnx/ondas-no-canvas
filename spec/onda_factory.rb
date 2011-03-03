module Support
  class OndaFactory
    DADOS_DEFAULT = {
      :amplitude => 10.0,
      :lambda => 10.0,
      :velocidade => 100.0,
      :frequencia => 10.0,
      :periodo => 0.1
    }
    def self.build(dados={})
      OndasNoCanvas::Modelos::Onda.new DADOS_DEFAULT.merge(dados)
    end
  end
end
