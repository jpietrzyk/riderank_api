module Routes
  module V1
    class OAuth2 < Grape::API
      helpers Grape::OAuth2::Helpers::OAuthParams

      namespace :oauth do
        params do
          use :oauth_token_params
        end
        post :token do
          token_response = Grape::OAuth2::Generators::Token
            .generate_for(env) do |request, response|

            client = Grape::OAuth2::Strategies::Base
              .authenticate_client(request)
            request.invalid_client! unless client

            resource_owner = User.oauth_authenticate(client,
              request.username,
              request.password
            )
            request.invalid_grant! if resource_owner.nil?

            response.access_token = Grape::OAuth2::Strategies::Password
              .process(request)
          end

          status token_response.status

          token_response.headers.each do |key, value|
            header key, value
          end

          body token_response.body
        end

        params do
          use :oauth_token_revocation_params
        end
        post :revoke do
          access_token = Grape::OAuth2.config.access_token_class
            .authenticate(params[:token], type: params[:token_type_hint])

          if access_token
            if access_token.client
              request = Rack::OAuth2::Server::Token::Request.new(env)

              client = Grape::OAuth2::Strategies::Base
                .authenticate_client(request)
              request.invalid_client! if client.nil?

              access_token.revoke! if client && client == access_token.client
            else
              # Access token is public
              access_token.revoke!
            end
          end

          # The authorization server responds with HTTP status code 200 if the token
          # has been revoked successfully or if the client submitted an invalid
          # token.
          #
          # @see https://tools.ietf.org/html/rfc7009#section-2.2 Revocation Response
          #
          status 200
          {}
        end
      end
    end
  end
end
