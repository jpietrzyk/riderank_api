module Routes
  module V1
    class Statistics < Grape::API
      resources :statistics do
        namespace :basic do
          desc 'Returns statistics'
          get do
            access_token_required! :write
            request = CreateBasicStats.new(current_resource_owner).perform!
            present request.response, with: Entities::V1::BasicStatistic if request.success?
          end
        end
      end
    end
  end
end
