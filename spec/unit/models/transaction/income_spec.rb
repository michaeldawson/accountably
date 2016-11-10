require 'spec_helper'

RSpec.describe Transaction::Income, type: :model do
  let(:expense) { Transaction::Income.new(valid_attributes) }
  let(:valid_attributes) {
    {
      account: Account.new,
      effective_date: Time.current,
      description: "Hey! I'm income.",
      amount: 100.0
    }
  }

  describe 'Callbacks' do
    before :each do
      valid_attributes.merge!(
        source: FactoryGirl.build_stubbed(:bank_account),
        account: FactoryGirl.build(:account)
      )
    end

    it 'increments the account balance on create' do
      expect {
        expense.save!
      }.to change {
        expense.account.balance
      }.by(100.0)
    end
  end
end
