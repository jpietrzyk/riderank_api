require 'spec_helper'

describe 'POST /oauth/token (Resource Owner Password Credentials flow)' do
  def app
    OUTER_APP
  end

  context 'with valid params' do
    let(:authentication_url) { '/v1/oauth/token' }
    let(:application) { create(:application) }
    let(:user) { create(:user) }

    let(:attributes) do
      {
        grant_type: 'invalid',
        email: user.email,
        password: 'secret',
        username: user.username
      }
    end

    let(:valid_params) do
      attributes
    end

    context 'when request is invalid' do
      it 'fails with invalid Grant Type' do
        post authentication_url, valid_params

        expect(AccessToken.count).to eq(0)

        expect(json['error']).to eq('unsupported_grant_type')
        expect(last_response.status).to eq(400)
      end

      it 'fails without Client Credentials' do
        post authentication_url, valid_params.merge(grant_type: 'password')

        expect(AccessToken.count).to eq(0)

        expect(json['error']).to eq('invalid_request')
        expect(last_response.status).to eq(400)
      end

      it 'fails with invalid Client Credentials' do
        post authentication_url, valid_params.merge(
          grant_type: 'password',
          password: 'secret',
          client_id: 'blah-blah',
          client_secret: application.secret
        )

        expect(AccessToken.count).to eq(0)

        expect(json['error']).to eq('invalid_client')
        expect(last_response.status).to eq(401)
      end

      it 'fails with invalid Resource Owner credentials' do
        post authentication_url, valid_params.merge(
          grant_type: 'password',
          password: 'invalid',
          username: 'invalid@example.com',
          client_id: application.key,
          client_secret: application.secret
        )

        expect(json['error']).to eq('invalid_grant')
        expect(json['error_description']).not_to be_blank
        expect(last_response.status).to eq 400
      end
    end

    context 'with valid data' do
      it 'returns access token' do
        post authentication_url, valid_params.merge(
          grant_type: 'password',
          password: 'secret',
          client_id: application.key,
          client_secret: application.secret
        )

        expect(AccessToken.count).to eq(1)
        expect(AccessToken.first.client_id).to eq application.id

        expect(json['access_token']).to be_present
        expect(json['token_type']).to eq 'bearer'
        expect(json['expires_in']).to eq 7200

        expect(last_response.status).to eq(200)
      end
    end
  end
end
