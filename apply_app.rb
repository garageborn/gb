require 'sinatra'
require File.expand_path('../lib/trello', __FILE__)

class ApplyApp < Sinatra::Base
  post '/' do
    card = Trello.new(params)
    card.save
    redirect '/jobs/applied'
  end
end
