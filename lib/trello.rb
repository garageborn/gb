require 'httparty'
require 'memoist'

class Trello
  include HTTParty
  extend Memoist
  base_uri 'https://api.trello.com/1'.freeze
  default_params key: ENV['GB_TRELLO_KEY'], token: ENV['GB_TRELLO_TOKEN']

  attr_accessor :email, :file, :job, :name, :cover, :trello_list

  def initialize(params)
    @email = params[:email]
    @file = params[:file]
    @job = params[:job]
    @name = params[:name]
    @cover = params[:cover]
    @trello_list = params[:trello_list]
  end

  def save
    return false unless card
    add_attachment
    true
  end

  private

  def description
    <<~EOF
      **job:** #{ job }
      **name:** #{ name }
      **email:** #{ email }
      **cover:** #{ cover }
    EOF
  end

  def card
    response = self.class.post('/cards'.freeze, body: {
      name: name,
      desc: description,
      idList: trello_list
    })
    return response if response.success?
    Raven.capture_message('UnprocessableEntity', extra: {
      card: description,
      reponse: response.parsed_response
    })
    nil
  end

  def card_id
    card.parsed_response['id']
  end

  def add_attachment
    return if file_url.blank?

    self.class.post("/cards/#{ card_id }/attachments", body: {
      url: file_url,
      mimeType: file[:type],
      name: file[:filename]
    })
  end

  def file_url
    return if file[:tempfile].blank?
    upload = Cloudinary::Uploader.upload(file[:tempfile])
    return if upload.blank?
    upload['secure_url']
  end

  memoize :description, :card, :card_id, :file_url
end
