require 'middleman-core/load_paths'
::Middleman.setup_load_paths

require 'middleman-core'
require 'middleman-core/rack'
require 'fileutils'

require 'sinatra'
require 'raven'
require 'cloudinary'

Dir.glob(File.expand_path('../initializers/**/*.rb', __FILE__)).each { |f| require f }
require File.expand_path('../../apply_app', __FILE__)

FileUtils.mkdir('../log') unless File.exist?('../log')
::Middleman::Logger.singleton("../log/#{ ENV['RACK_ENV'] }.log")
