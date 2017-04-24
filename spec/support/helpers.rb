module Helpers
  include Rack::Test::Methods

  def json
    JSON.parse(last_response.body)
  rescue
    raise StandardError, 'API request returned invalid json'
  end
end
