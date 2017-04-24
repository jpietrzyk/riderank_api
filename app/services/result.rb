Result = ImmutableStruct.new(:status, :response) do
  def success?
    status.eql? :success
  end

  def failure?
    !success?
  end
end
