module Routes
  module V1
    class Users < Grape::API
      resources :users do
        desc 'Create a user.'
        params do
          requires :email, type: String
          requires :password, type: String
          requires :username, type: String
        end
        post do
          request = CreateUser.new(params).perform!
          if request.success?
            present request.response, with: Entities::V1::User
          else
            #
          end
        end
      end
    end
  end
end
