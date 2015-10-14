source 'https://rubygems.org'


gem 'rails', '4.2.4'
gem 'bootstrap-sass', '~> 3.3.5.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'

gem 'will_paginate', '~> 3.0.6'
gem 'sdoc', '~> 0.4.0',          group: :doc
# bundle exec rake doc:rails generates the API under doc/api.

gem 'spring',        group: :development
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
	gem 'sqlite3'
	gem 'pry'
end

group :production do
  gem 'unicorn'
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
end