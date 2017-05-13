class ApiError < StandardError
  def initialize(msg="An API error occured")
    super
  end
end
