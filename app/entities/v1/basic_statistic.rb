module Entities
  module V1
    class BasicStatistic < Grape::Entity
      format_with(:iso_timestamp, &:iso8601)
      expose :expenses
      expose :distance
    end
  end
end
