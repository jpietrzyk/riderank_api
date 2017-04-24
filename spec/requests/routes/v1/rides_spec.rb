require 'spec_helper'

describe Routes::V1::Rides do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  let(:application) { Application.create(name: 'App1') }
  let(:taxi_provider) { create(:taxi_provider) }
  let(:user) { create(:user) }
  let(:ride) { create(:ride, user: user, taxi_provider: taxi_provider) }

  let(:attributes) do
    {
      start_coordinates: ['0', '0'],
      end_coordinates: ['1', '1'],
      cost: 123,
      taxi_provider_id: taxi_provider.id.to_s,
      user_id: user.id.to_s
    }
  end

  let(:valid_params) do
    attributes
  end

  describe 'GET /v1/rides' do
    it 'returns HTTP status 200' do
      access_token = AccessToken.create_for(application, user, 'read')

      get '/v1/rides', access_token: access_token.token
      expect(last_response.status).to eq 200
    end
  end

  describe 'GET /v1/rides/:ride_id' do
    it 'returns HTTP status 200' do
      access_token = AccessToken.create_for(application, user, 'read')

      get "/v1/rides/#{ride.id}", access_token: access_token.token
      expect(last_response.status).to eq 200
    end
  end

  describe 'POST /v1/rides' do
    context 'with valid attributes' do
      it 'returns HTTP status 201 - Created' do
        access_token = AccessToken.create_for(application, user, 'read write')

        post '/v1/rides', valid_params.merge(access_token: access_token.token)
        expect(last_response.status).to eq 201
      end

      it 'creates the ride' do
        access_token = AccessToken.create_for(application, user, 'read write')

        post '/v1/rides', valid_params.merge(access_token: access_token.token)
        ride = Ride.find(json['id'])
        expect(ride).to_not eq nil
      end

      it 'creates the ride with the specified attributes' do
        access_token = AccessToken.create_for(application, user, 'read write')

        post '/v1/rides', valid_params.merge(access_token: access_token.token)
        ride = Ride.find(json['id'])
        expect(ride.start_coordinates).to eq attributes[:start_coordinates]
        expect(ride.end_coordinates).to eq attributes[:end_coordinates]
        expect(ride.cost).to eq attributes[:cost]
        expect(ride.taxi_provider.id.to_s).to eq attributes[:taxi_provider_id]
        expect(ride.user.id.to_s).to eq attributes[:user_id]
      end
    end

    context 'with invalid attributes' do
      it 'responds with 400' do
        valid_params.delete(:email)
        post '/v1/users', valid_params.to_json
        expect(last_response.status).to eq 400
      end
    end
  end
end
