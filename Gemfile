source 'http://rubygems.org'

gem 'rails'
gem 'activejob_backport' # required for rails 4.1 and 4.2
gem 'pg'

group :production do 
  gem 'rails_12factor'
end

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'font-awesome-rails', '~> 4.5'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'
gem 'sprockets-rails', :require => 'sprockets/railtie'

gem 'haml-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'will_paginate', '~> 3.1.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'


gem 'devise'
gem 'bcrypt', platforms: :ruby, :require => "bcrypt"

gem 'redcarpet'
gem 'activejob'

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'simplecov'
end

ruby "2.3.3"