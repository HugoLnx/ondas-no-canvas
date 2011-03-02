def criar_pacote_de_javascript_para_os_arquivos(*arquivos)
  PacoteDeJavascript.new(arquivos)
end

class PacoteDeJavascript 
  def initialize(arquivos)
    @arquivos = arquivos
  end

  def e_salvar_em(path_do_pacote)
    cria_diretorios_para(path_do_pacote)
    secretaria = Sprockets::Secretary.new :source_files => @arquivos

    pacote = secretaria.concatenation
    pacote.save_to path_do_pacote

    secretaria.install_assets
  end

  def cria_diretorios_para(path)
    File.dirname(path).split('/').inject('./') do |path_diretorio_antigo,diretorio_atual|
      path_do_diretorio_atual = File.join(path_diretorio_antigo,diretorio_atual)
      Dir.mkdir(path_do_diretorio_atual) unless File.exist? path_do_diretorio_atual
      path_do_diretorio_atual
    end
  end
end
