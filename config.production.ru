require 'rack'
require 'rack/contrib/try_static'
require 'rack/contrib/not_found'
require File.expand_path('../config/environment', __FILE__)

use Raven::Rack
map '/apply' do
  run ApplyApp
end

use Rack::TryStatic,
  root: 'build',
  urls: %w[/],
  try: ['.html', 'index.html', '/index.html']

run Rack::NotFound.new('build/404/index.html')
