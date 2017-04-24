module Routes
  module V1
    class Rides < Grape::API
      before do
        access_token_required!
      end
      resources :rides do

        desc 'Returns all rides'
        get do
          rides = current_resource_owner.rides
          present rides, with: Entities::V1::Ride
        end

        desc "Return a specific ride"
        params do
          requires :id, type: String
        end
        get ':id' do
          ride = current_resource_owner.rides.find(params[:id])
          present ride, with: Entities::V1::Ride
        end

        desc 'Create a ride'
        params do
          requires :start_coordinates, type: Array
          requires :end_coordinates, type: Array
          requires :cost, type: Integer
          requires :taxi_provider_id
          requires :user_id
        end
        post do
          request = CreateRide.new(params).perform!
          if request.success?
            present request.response, with: Entities::V1::Ride
          else
            #
          end
        end
      end
    end
  end
end
