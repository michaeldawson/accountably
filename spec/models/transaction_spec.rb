require 'spec_helper'

RSpec.describe Transaction, type: :model do
  let(:transaction) { Transaction.new(valid_attributes) }
  let(:valid_attributes) {
    {
      account: Account.new,
      effective_date: Time.current,
      description: "Hey! I'm a transaction",
      amount: 100
    }
  }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(transaction).to be_valid
    end

    it 'should not be valid without a account' do
      valid_attributes[:account] = nil
      expect(transaction).not_to be_valid
    end

    it 'should not be valid without a date' do
      valid_attributes[:effective_date] = nil
      expect(transaction).not_to be_valid
    end

    it 'should not be valid without a description' do
      valid_attributes[:description] = nil
      expect(transaction).not_to be_valid
    end

    it 'should not be valid without an amount' do
      valid_attributes[:amount] = nil
      expect(transaction).not_to be_valid
    end
  end

  describe 'Callbacks' do
    it 'negative values decrement the account balance on create' do
      valid_attributes[:amount] = -100

      expect {
        transaction.save
      }.to change {
        transaction.account.balance
      }.by(-100)
    end
  end
end
