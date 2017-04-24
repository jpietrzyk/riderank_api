class CreateUser

  def initialize(params)
    @params = params
  end

  def perform!
    create_new_user
  end

  private

  attr_reader :params

  def create_new_user
    result = User.create(
      username: params[:username],
      email: params[:email],
      password: params[:password]
    )

    if result
      Result.new(status: :success, response: result)
    else
      Result.new(status: :failure, message: result.errors)
    end
  end
end
