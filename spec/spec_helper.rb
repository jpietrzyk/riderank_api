ENV['RACK_ENV'] = 'test'

require 'coveralls'

if Coveralls.should_run?
  Coveralls.wear!
else
  require 'simplecov'
  SimpleCov.start
end

require 'bundler/setup'
Bundler.setup

require 'rack/test'
require 'database_cleaner'
require 'ostruct'
require 'factory_girl'

require 'grape_oauth2'

require 'factories.rb'
require 'support/helpers.rb'

require File.expand_path('../../config/application.rb', __FILE__)

# Defining the app to test is required for rack-test
OUTER_APP = Rack::Builder.parse_file('config.ru').first

RSpec.configure do |config|
  config.include Helpers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
