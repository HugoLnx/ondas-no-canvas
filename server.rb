$LOAD_PATH << "./lib"
require 'rubygems'
require 'sinatra'
require 'yaml'
require 'ondas_in_cloud'

OndasInCloud::Modelos::Infra::Application.run
