require 'sinatra'

class ApplyApp < Sinatra::Base
  get '/' do
    'Hello World (Sinatra)'
  end
end
