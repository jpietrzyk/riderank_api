require 'spec_helper'

describe Entities::V1::TaxiProvider do
  describe 'exposiures' do
    it 'expose id' do
      expect(described_class.find_exposure(:id)).to_not be_nil
    end

    it 'expose start coordinates' do
      expect(described_class.find_exposure(:name)).to_not be_nil
    end
  end
end
