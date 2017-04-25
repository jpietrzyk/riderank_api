class Ride
  require 'haversine'

  include Mongoid::Document
  include Mongoid::Timestamps

  field :start_coordinates, type: Array
  field :end_coordinates, type: Array
  field :cost, type: Integer # we should keep currency in eurocents
  field :ride_distance, type: Float
  field :ride_date, type: Date, default: Date.current

  belongs_to :taxi_provider
  belongs_to :user

  validates :start_coordinates, presence: true
  validates :end_coordinates, presence: true
  validates :cost, presence: true
  validates :ride_date, presence: true

  index({ start_coordinates: '2d' }, min: -180, max: 180)
  index({ end_coordinates: '2d' }, min: -180, max: 180)

  before_save :update_distance

  def distance
    Haversine.distance(start_coordinates, end_coordinates)
  end

  private

  def update_distance
    self.ride_distance = Haversine.distance(start_coordinates,
                                            end_coordinates).to_m
  end
end
