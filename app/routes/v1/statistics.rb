module Routes
  module V1
    class Statistics < Grape::API
      resources :statistics do
        namespace :basic do
          desc 'Returns statistics'
          get do
            access_token_required! :write
            request = CreateBasicStats.new(current_resource_owner).perform!
            if request.success?
              present request.response,
                      with: Entities::V1::BasicStatistic
            end
          end
        end

        namespace :advanced do
          desc 'Returns statistics'
          get do
            access_token_required! :write
            request = CreateAdvancedStats.new(current_resource_owner).perform!
            if request.success?
              present request.response,
                      with: Entities::V1::AdvancedStatistic
            end
          end
        end
      end
    end
  end
end
