# Gemfile
source 'https://rubygems.org'

gem 'grape'
gem 'grape-entity', '~> 0.5.1'
gem 'grape_oauth2', git: 'https://github.com/nbulaj/grape_oauth2.git'

gem 'grape-swagger'

gem 'bcrypt'
gem 'grape_token_auth'
gem 'rack'
gem 'warden'

gem 'immutable_struct'
gem 'haversine'
gem 'mongoid'
gem 'rack-cors', require: 'rack/cors'
gem 'rake'

group :development do
  gem 'pry'
  gem 'shotgun'
end

group :test do
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'rubocop', require: false
end
