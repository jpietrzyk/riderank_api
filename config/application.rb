require './config/environment'
require 'grape'
require 'grape-entity'
require 'grape_oauth2'

load File.expand_path('../db.rb', __FILE__)

Grape::OAuth2.configure do |config|
  config.client_class_name = 'Application'
  config.access_token_class_name = 'AccessToken'
  config.resource_owner_class_name = 'User'
  # config.access_grant_class_name = 'AccessCode'

  config.allowed_grant_types << 'refresh_token'
end

# Load application
[
  %w[app models ** *.rb],
  %w[app entities v* *.rb],
  %w[app entities ** *.rb],
  %w[app services ** *.rb],
  %w[app routes v* *.rb],
  %w[app routes ** *.rb]
].each do |pattern|
  Dir.glob(Config.root.join(*pattern)).each { |file| require file }
end
