namespace :assets do
  desc 'Precompile assets'
  task precompile: :clean do
    sh 'bundle exec middleman build'
  end

  desc 'Remove compiled assets'
  task :clean do
    sh "rm -rf #{ File.dirname(__FILE__) }/build/*"
  end

end
