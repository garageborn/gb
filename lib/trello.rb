require 'httparty'
require 'memoist'

class Trello
  include HTTParty
  extend Memoist

  base_uri 'https://api.trello.com/1'.freeze
  format :json
  default_params key: ENV['TRELLO_KEY'], token: ENV['TRELLO_TOKEN']

  attr_accessor :email, :file, :job, :name, :salary, :trello_list

  def initialize(params)
    @email = params[:email]
    @file = params[:file]
    @job = params[:job]
    @name = params[:name]
    @salary = params[:salary]
    @trello_list = params[:trello_list]
  end

  def save
    return false unless card
    upload_file if file
    true
  end

  private

  def description
    <<~EOF
      **job:** #{ job }
      **name:** #{ name }
      **email:** #{ email }
      **salary:** #{ salary }
    EOF
  end

  def card
    response = self.class.post('/cards'.freeze, body: {
      name: name,
      desc: description,
      idList: trello_list
    })
    return unless response.success?
    response
  end

  def card_id
    card.parsed_response['id']
  end

  def upload_file
    self.class.post("/cards/#{ card_id }/attachments", body: {
      file: file[:tempfile],
      mimeType: file[:type],
      name: file[:filename]
    })
  end

  memoize :description, :card, :card_id
end
