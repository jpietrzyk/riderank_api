require 'spec_helper'

describe Routes::V1::TaxiProviders do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  before do
    header 'Content-Type', 'application/vnd.api+json'
  end

  let(:taxi_provider) { create(:taxi_provider) }

  describe 'GET /v1/taxi_providers' do
    it 'returns HTTP status 200' do
      get '/v1/taxi_providers'
      expect(last_response.status).to eq 200
    end
  end

  describe 'GET /v1/taxi_providers/:taxi_provider_id' do
    it 'returns HTTP status 200' do
      get "/v1/taxi_providers/#{taxi_provider.id}"
      expect(last_response.status).to eq 200
    end
  end
end
