$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'config/application'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: %i[get post put delete options]
  end
end

run Rack::Cascade.new([
                        Routes::V1::API
                      ])
