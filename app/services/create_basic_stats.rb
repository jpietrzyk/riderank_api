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
    rides = rides_within_data_range(week_range)
    Result.new(status: :success, response: { expenses: expenses(rides), distance: distance(rides) })
  end

  def distance(rides)
    rides.inject(0) { |sum, ride| sum + ride.distance.to_meters }
  end

  def expenses(rides)
    rides.inject(0) { |sum, ride| sum + ride.cost }
  end

  def rides_within_data_range(range)
    Ride.where(created_at: range)
  end

  def week_range
    d = Date.today
    (d.beginning_of_week..d.end_of_week)
  end
end
