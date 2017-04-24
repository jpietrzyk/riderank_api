require 'spec_helper'

describe Entities::V1::User do
  describe 'exposiures' do
    it 'expose id' do
      expect(described_class.find_exposure(:id)).to_not be_nil
    end

    it 'expose username' do
      expect(described_class.find_exposure(:username)).to_not be_nil
    end

    it 'expose email' do
      expect(described_class.find_exposure(:username)).to_not be_nil
    end
  end
end
