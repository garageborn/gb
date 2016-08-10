namespace :assets do
  desc 'Precompile assets'
  task precompile: :clean do
    sh 'bin/middleman build'
  end

  desc 'Remove compiled assets'
  task :clean do
    sh "rm -rf #{ File.expand_path('../../build', __FILE__) }/*"
  end
end
