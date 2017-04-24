require 'spec_helper'

describe TaxiProvider do
  it 'has a valid factory' do
    expect(build(:taxi_provider)).to be_valid
  end

  describe 'validations' do

    it 'is invalid without name' do
      expect(build(:taxi_provider, name: nil)).to_not be_valid
    end
  end
end
