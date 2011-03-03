require './lib/pacote_de_javascript'
require 'sprockets'

task :rmswp do
  Dir["**/*.swp"].each do |backup|
    File.delete backup
  end
end

task :pacotejs do
  criar_pacote_de_javascript_para_os_arquivos("public/js/jquery.js","public/js/ajax.js","public/js/google.analitics.js","public/js/animacao/**/*.js").
    e_salvar_em("public/tmp/pacote.todos.js")
end
