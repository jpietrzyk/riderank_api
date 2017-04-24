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
          present request.response, with: Entities::V1::User if request.success?
        end
      end
    end
  end
end
