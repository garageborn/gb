require 'sinatra'
require 'lib/trello'

class ApplyApp < Sinatra::Base
  post '/' do
    card = Trello.new(params)
    card.save
    redirect '/jobs/applied'
  end
end
