class CreateBasicStats
  def initialize(user)
    @user = user
  end

  def perform!
    basic_stats
  end

  private

  attr_reader :user

  def basic_stats
    Result.new(status: :success, response: build_stats )
  end

  def build_stats
    data = agregate_data.first
    {
      expenses: data.try(:expenses),
      distance: data.try(:distance)
    }
  end

  def agregate_data
    user.rides.collection.aggregate(
      [
        {
          '$match': {
            created_at: {
              '$gte': week_range[:first_day], '$lte': week_range[:last_day]
              }
            }
          },
          {
            '$group': {
            '_id': { day: { '$week': '$ride_date' } },
            expenses: { '$sum': '$cost' },
            distance: { '$sum': '$ride_distance' },
            rides: { '$sum': 1 },
          }
        }
      ]
    )
  end

  def week_range
    d = Date.today
    {
      first_day: d.beginning_of_week,
      last_day: d.end_of_week
    }
  end
end
