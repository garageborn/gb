workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

if ENV['RACK_ENV'] == 'production'
  rackup File.expand_path('../config.production.ru', __FILE__)
else
  rackup DefaultRackup
end

port ENV['PORT'] || 3000
environment ENV['RACK_ENV'] || 'development'
