require 'spec_helper'

describe Routes::V1::Ping do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  before do
    header 'Content-Type', 'application/vnd.api+json'
  end

  describe 'GET /v1/status' do
    it 'returns 200 and status ok' do
      get '/v1/ping'
      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).to eq('pong')
    end
  end
end
