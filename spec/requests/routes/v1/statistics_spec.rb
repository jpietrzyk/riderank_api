require 'spec_helper'

describe Routes::V1::Rides do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  let(:application) { create(:application) }
  let(:user) { create(:user) }

  describe 'GET /v1/statistics/basic' do
    it 'returns Forbidden with token that does not has required scopes' do
      access_token = AccessToken.create_for(application, user, 'read')
      get "/v1/statistics/basic", access_token: access_token.token

      expect(last_response.status).to eq 403
      expect(json['error']).to eq('forbidden')
    end

    it 'returns statistics when user is authorized' do
      access_token = AccessToken.create_for(application, user, 'read write')
      get '/v1/statistics/basic', access_token: access_token.token

      expect(last_response.status).to eq 200
      expect(json).to include('expenses', 'distance')
    end
  end
end
