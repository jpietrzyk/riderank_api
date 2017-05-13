require 'spec_helper'

describe 'Me' do

  def app
    OUTER_APP
  end

  let(:application) { create(:application) }
  let(:user) { create(:user) }

  context 'with access token' do
    it 'returns data without authorization for public route' do
      access_token = AccessToken.create_for(application, user)

      get '/v1/me', access_token: access_token.token

      expect(last_response.status).to eq 200
      expect(json).to include('username')
    end
  end

  context 'without access token' do
    it 'returns data without authorization for public route' do
      get '/v1/me'
      expect(last_response.status).to eq 401
      expect(json['error']).to eq('unauthorized')
    end
  end
end
