# Gemfile
source 'https://rubygems.org'

gem 'rack'
gem 'grape'
gem 'grape-entity', '~> 0.5.1'
gem 'grape_oauth2', git: 'https://github.com/nbulaj/grape_oauth2.git'

gem 'mongoid'
gem 'immutable_struct'
gem 'warden'
gem 'grape_token_auth'
gem "bcrypt"
gem 'rake'
gem 'rack-cors', require: 'rack/cors'

group :development do
  gem 'shotgun'
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'coveralls', require: false
  gem 'rack-test', require: 'rack/test'
  gem 'rubocop', require: false
end
