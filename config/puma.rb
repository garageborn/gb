workers Integer(ENV['GB_WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['GB_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

if ENV['RACK_ENV'] == 'production'
  rackup 'config.production.ru'
else
  rackup DefaultRackup
end

port ENV['GB_PORT'] || 3000
environment ENV['RACK_ENV'] || 'development'
