require 'spec_helper'

RSpec.describe Transaction::Income, type: :model do
  let(:expense) { Transaction::Income.new(valid_attributes) }
  let(:valid_attributes) {
    {
      account: Account.new,
      effective_date: Time.current,
      description: "Hey! I'm income.",
      amount: 100_00
    }
  }

  describe 'Callbacks' do
    it 'increments the account balance on create' do
      expect {
        expense.save
      }.to change {
        expense.account.balance
      }.by(100_00)
    end
  end
end
