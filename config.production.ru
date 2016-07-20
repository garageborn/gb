require 'rack'
require 'rack/contrib/try_static'
require 'rack/contrib/not_found'

require File.expand_path('../apply_app', __FILE__)

map '/apply' do
  run ApplyApp
end

use Rack::TryStatic,
  root: 'build',
  urls: %w[/],
  try: ['.html', 'index.html', '/index.html']

run Rack::NotFound.new('build/404/index.html')
