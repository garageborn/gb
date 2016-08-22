require 'sinatra'
require File.expand_path('../lib/trello', __FILE__)

class ApplyApp < Sinatra::Base
  post '/' do
    p '-aaaaaaaaaaa'
    asdasasd
    card = Trello.new(params)
    p card.save
    redirect '/jobs/applied'
  end
end
