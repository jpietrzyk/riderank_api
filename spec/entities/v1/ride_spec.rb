require 'spec_helper'

describe Entities::V1::Ride do
  describe 'exposiures' do
    it 'expose id' do
      expect(described_class.find_exposure(:id)).to_not be_nil
    end

    it 'expose start coordinates' do
      expect(described_class.find_exposure(:start_coordinates)).to_not be_nil
    end

    it 'expose end_coordinates' do
      expect(described_class.find_exposure(:end_coordinates)).to_not be_nil
    end

    it 'expose cost' do
      expect(described_class.find_exposure(:cost)).to_not be_nil
    end

    it 'expose taxi_provider' do
      expect(described_class.find_exposure(:taxi_provider)).to_not be_nil
    end

    it 'expose user' do
      expect(described_class.find_exposure(:user)).to_not be_nil
    end
  end
end
