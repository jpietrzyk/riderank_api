module Routes
  module V1
    class API < Grape::API
      version 'v1'
      format :json
      # formatter :json, -> (object, _env) { object.to_json }
      # content_type :json, 'application/vnd.api+json'

      # include Grape::OAuth2.api

      helpers do
        def base_url
          "http://#{request.host}:#{request.port}/api/#{version}"
        end

        def invalid_media_type!
          error!('Unsupported media type', 415)
        end

        def json_api?
          request.content_type == 'application/vnd.api+json'
        end
      end

      before do
        # invalid_media_type! unless json_api?
      end

      helpers Grape::OAuth2::Helpers::AccessTokenHelpers

      # Inject token authentication middleware
      use(*Grape::OAuth2.middleware)

      # Mount custom Grape::OAuth2 Token endpoint
      mount Routes::V1::OAuth2
      # Mount default Grape::OAuth2 Authorization endpoint
      mount Grape::OAuth2::Endpoints::Authorize

      mount Routes::V1::Ping
      mount Routes::V1::Rides
      mount Routes::V1::TaxiProviders
      mount Routes::V1::Users
      mount Routes::V1::Statistics

      add_swagger_documentation
    end
  end
end
