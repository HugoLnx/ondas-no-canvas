$LOAD_PATH << "./lib"
require 'rubygems'
require 'sinatra'
require 'haml'
require 'ondas_no_canvas'

OndasNoCanvas::Modelos::Infra::Application.run
