module Routes
  module V1
    class TaxiProviders < Grape::API
      resources :taxi_providers do
        desc 'Returns all rides'
        get do
          taxi_providers = TaxiProvider.all
          present taxi_providers, with: Entities::V1::TaxiProvider
        end

        desc 'Return a specific ride'
        params do
          requires :id, type: String
        end
        get ':id' do
          taxi_provider = TaxiProvider.find(params[:id])
          present taxi_provider, with: Entities::V1::TaxiProvider
        end
      end
    end
  end
end
