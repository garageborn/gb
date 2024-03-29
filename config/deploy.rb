lock '3.8.0'

set :application, 'gb'
set :repo_url, 'git@github.com:garageborn/gb.git'
set :keep_releases, 10
set :deploy_to, '/home/garageborn/gb'
set :pty, true
set :root, File.expand_path(File.dirname(__FILE__) + '/../')
set :ssh_options, { forward_agent: true, port: 41858 }
set :branch, -> { ENV['branch'] || `git rev-parse --abbrev-ref HEAD`.chomp }
set :use_sudo, false
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# rbenv
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{ fetch(:rbenv_path) } RBENV_VERSION=#{ fetch(:rbenv_ruby) } #{ fetch(:rbenv_path) }/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby middleman}
set :rbenv_roles, :all

# puma
set :puma_threads, [0, 1]
set :puma_workers, 1
