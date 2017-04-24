require 'spec_helper'

describe Entities::V1::BasicStatistic do
  describe 'exposiures' do
    it 'expose expenses' do
      expect(described_class.find_exposure(:expenses)).to_not be_nil
    end

    it 'expose distance' do
      expect(described_class.find_exposure(:distance)).to_not be_nil
    end
  end
end
