class CreateRide
  def initialize(params)
    @params = params
  end

  def perform!
    create_new_ride
  end

  private

  attr_reader :params

  def create_new_ride
    result = Ride.create(
      valid_parameters
    )

    if result
      Result.new(status: :success, response: result)
    else
      Result.new(status: :failure, message: result.errors)
    end
  end

  def valid_parameters
    {
      start_coordinates: params[:start_coordinates],
      end_coordinates: params[:end_coordinates],
      cost: params[:cost],
      taxi_provider: taxi_provider,
      user: user
    }
  end

  def taxi_provider
    TaxiProvider.find(@params[:taxi_provider_id])
  end

  def user
    User.find(@params[:user_id])
  end
end
