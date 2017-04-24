module Entities
  module V1
    class Ride < Grape::Entity
      require_relative 'taxi_provider'
      require_relative 'user'

      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id
      expose :start_coordinates
      expose :end_coordinates
      expose :cost
      expose :taxi_provider, using: Entities::V1::TaxiProvider
      expose :user, using: Entities::V1::User
    end
  end
end
