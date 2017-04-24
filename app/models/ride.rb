class Ride
  include Mongoid::Document
  include Mongoid::Timestamps

  field :start_coordinates, type: Array
  field :end_coordinates, type: Array
  field :cost, type: Integer # we should keep currency in eurocents

  belongs_to :taxi_provider
  belongs_to :user

  validates :start_coordinates, presence: true
  validates :end_coordinates, presence: true
  validates :cost, presence: true

  index({ start_coordinates: "2d" }, { min: -180, max: 180 })
  index({ end_coordinates: "2d" }, { min: -180, max: 180 })
end
