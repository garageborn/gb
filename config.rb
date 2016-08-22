require File.expand_path('../config/sentry', __FILE__)
require File.expand_path('../apply_app', __FILE__)

###
# Page options, layouts, aliases and proxies
###

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
ignore '/jobs/show.html'

data.jobs.each do |job|
  proxy "/jobs/#{ job.slug }/index.html", '/jobs/show.html', layout: 'layout', locals: {
    slug: job.slug,
    trello_list: job.trello_list,
    job_title: job.title,
    job_description: job.body
  }
end

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :dotenv
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def job_path(job)
    "/jobs/#{ job.slug }"
  end
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

activate :sprockets
activate :directory_indexes
set :haml, { ugly: true, format: :html5 }

use Raven::Rack
map '/apply' do
  run ApplyApp
end
