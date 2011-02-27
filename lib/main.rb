$LOAD_PATH << "./lib"
require 'rubygems'
require 'sinatra'
require 'ondas_in_cloud'

OndasInCloud::Modelos::Infra::Application.run
