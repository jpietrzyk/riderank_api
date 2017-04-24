require 'spec_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'validations' do

    it 'is invalid without email' do
      expect(build(:user, email: nil)).to_not be_valid
    end

    it 'is invalid without username' do
      expect(build(:user, username: nil)).to_not be_valid
    end

    it 'is invalid without password' do
      expect(build(:user, password: nil)).to_not be_valid
    end
  end
end
