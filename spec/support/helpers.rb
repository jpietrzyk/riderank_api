module Helpers
  include Rack::Test::Methods

  def json
    JSON.parse(last_response.body) rescue fail StandardError, 'API request returned invalid json'
  end
end
