module Entities
  module V1
    class AdvancedStatistic < Grape::Entity
      format_with(:iso_timestamp, &:iso8601)
      expose :day_id
      expose :date
      expose :avg_expenses
      expose :total_distance
      expose :avg_distance
      expose :providers
    end
  end
end
