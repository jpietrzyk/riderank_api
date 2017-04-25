class CreateAdvancedStats
  def initialize(user)
    @user = user
  end

  def perform!
    advanced_stats
  end

  private

  attr_reader :user

  def advanced_stats
    Result.new(status: :success, response: build_stats)
  end

  def build_stats
    days = []
    agregate_data.each do |day|
      days << Stats::Day.new(
        day_id: day['_id']['day'],
        date: Date.parse(day['_id']['date']),
        avg_expenses: day['avg_expenses'],
        total_distance: day['distance'],
        avg_distance: day['avg_distance'],
        providers: day['taxi_operators'].flatten
      )
    end
    days
  end

  def agregate_data
    user.rides.collection.aggregate(
      [
        {
          '$match': {
            created_at: {
              '$gte': month_range[:first_day], '$lte': month_range[:last_day]
              }
            }
          },
          {
            '$lookup': {
              from: 'taxi_providers',
              localField: 'taxi_provider_id',
              foreignField: '_id',
              as: 'taxi_provider'
            }
          },
          {
            '$group': {
            '_id': { day: { '$dayOfMonth': '$ride_date' },
                     date: { '$dateToString': {
                       format: '%Y-%m-%d', date: '$ride_date'
                       }
                     }
                   },
            avg_expenses: { '$avg': { '$sum': '$cost' } },
            distance: { '$sum': '$ride_distance' },
            avg_distance: { '$avg': { '$sum': '$ride_distance' } },
            taxi_operators: { '$addToSet': '$taxi_provider.name' },
            rides: { '$sum': 1 },
          }
        }
      ]
    )
  end

  def month_range
    d = Date.today
    {
      first_day: d.beginning_of_month,
      last_day: d.end_of_month
    }
  end
end
