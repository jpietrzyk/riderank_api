module Routes
  module V1
    class Me < Grape::API
      get :me do
        access_token_required!

        present(current_resource_owner, with: Entities::V1::User)
      end
    end
  end
end
