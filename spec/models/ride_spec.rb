require 'spec_helper'

describe Ride do
  it 'has a valid factory' do
    expect(build(:ride)).to be_valid
  end

  describe 'validations' do
    it 'is invalid without start location' do
      expect(build(:ride, start_coordinates: nil)).to_not be_valid
    end

    it 'is invalid without end location' do
      expect(build(:ride, end_coordinates: nil)).to_not be_valid
    end

    it 'is invalid without costt' do
      expect(build(:ride, cost: nil)).to_not be_valid
    end

    it 'is invalid without taxi provider' do
      expect(build(:ride, taxi_provider: nil)).to_not be_valid
    end

    it 'is invalid without user' do
      expect(build(:ride, user: nil)).to_not be_valid
    end
  end

  describe '#distance' do
    it 'should count and return valid distance' do
      ride = build(:ride, start_coordinates: [0, 0], end_coordinates: [1, 0])
      # one degree has aproximately 69 miles
      expect(ride.distance.to_miles).to be_between(69, 70)
    end
  end
end
