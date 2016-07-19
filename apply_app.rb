require 'sinatra'

class ApplyApp < Sinatra::Base
  post '/' do
    'Hello World (Sinatra)'
  end
end
