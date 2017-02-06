require File.expand_path('../config/environment', __FILE__)

use Raven::Rack
app = ::Middleman::Application.new
run ::Middleman::Rack.new(app).to_app
