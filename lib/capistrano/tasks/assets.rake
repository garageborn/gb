namespace :assets do
  desc 'Precompile assets'
  task precompile: :clean do
    on roles(:app) do
      within fetch(:release_path) do
        execute(:bundle, :exec, :middleman, :build)
      end
    end
  end

  desc 'Remove compiled assets'
  task :clean do
    on roles(:app) do
      within fetch(:release_path) do
        execute('rm -rf build/*')
      end
    end
  end

  after 'deploy:updated', 'assets:precompile'
end
