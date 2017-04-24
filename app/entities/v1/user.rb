module Entities
  module V1
    class User < Grape::Entity
      expose :id
      expose :username
      expose :email
    end
  end
end
