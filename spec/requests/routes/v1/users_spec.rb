require 'spec_helper'

describe Routes::V1::Users do
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  let(:user) { create(:user) }

  let(:attributes) do
    {
      username: 'test_user',
      email: 'test_email@mail.com',
      password: 'secret'
    }
  end

  let(:valid_params) do
    attributes
  end

  describe 'POST /v1/users' do
    context 'with valid attributes' do
      it 'returns HTTP status 201 - Created' do
        post "/v1/users", valid_params
        expect(last_response.status).to eq 201
      end

      it 'creates the user' do
        post "/v1/users", valid_params
        user = User.find_by(username: json['username'])
        expect(user).to_not eq nil
      end

      it 'creates the user with the specified attributes' do
        post "/v1/users", valid_params
        user = User.find_by(username: json['username'])
        expect(user.username).to eq attributes[:username]
        expect(user.email).to eq attributes[:email]
      end
    end
    context 'with invalid attributes' do
      it 'responds with 400' do
        valid_params.delete(:username)
        post "/v1/users", valid_params
        expect(last_response.status).to eq 400
      end
    end
  end

end
