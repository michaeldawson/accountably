require 'spec_helper'

RSpec.describe Account, type: :model do
  let(:account) { Account.new(valid_attributes) }
  let(:valid_attributes) {
    {
      budget: Budget.new,
      amount: 100,
      balance: 0
    }
  }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(account).to be_valid
    end

    it 'should not be valid without a budget' do
      valid_attributes[:budget] = nil
      expect(account).not_to be_valid
    end

    it 'should not be valid without an amount' do
      valid_attributes[:amount] = nil
      expect(account).not_to be_valid
    end

    it 'should not be valid with a negative amount' do
      valid_attributes[:amount] = -100
      expect(account).not_to be_valid
    end

    it 'should not be valid without a balance' do
      valid_attributes[:balance] = nil
      expect(account).not_to be_valid
    end
  end
end
