$LOAD_PATH << "./lib"
require 'rubygems'
require 'sinatra'
require 'haml'
require 'sprockets'
require 'pacote_de_javascript'
require 'ondas_no_canvas'

criar_pacote_de_javascript_para_os_arquivos("public/js/jquery.js","public/js/ajax.js","public/js/animacao/**/*.js").
  e_salvar_em("public/tmp/pacote.todos.js")

OndasNoCanvas::Modelos::Infra::Application.run
