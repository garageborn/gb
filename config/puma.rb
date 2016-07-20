workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

if ENV['RACK_ENV'] == 'production'
  rackup 'config.production.ru'
else
  rackup DefaultRackup
end

port ENV['PORT'] || 3000
environment ENV['RACK_ENV'] || 'development'
