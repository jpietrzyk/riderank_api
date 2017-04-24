module Entities
  module V1
    class TaxiProvider < Grape::Entity
      expose :id
      expose :name
    end
  end
end
