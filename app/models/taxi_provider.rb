class TaxiProvider
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :rides

  validates :name, presence: true
  validates :name, uniqueness: true

  index({ name: 1 }, unique: true, name: 'name_index')
end
