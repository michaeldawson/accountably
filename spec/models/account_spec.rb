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

  describe '#spent_this_cycle' do
    context 'with debit transactions in this cycle and outside of this cycle' do
      let(:cycle) { 1.week.ago..Time.current }

      let!(:transaction_1) {
        FactoryGirl.create(:transaction, account: account, effective_date: cycle.first - 1.day, amount: 100)
      }
      let!(:transaction_2) {
        FactoryGirl.create(:transaction, account: account, effective_date: cycle.first + 1.day, amount: 120)
      }

      before :each do
        account.save!
      end

      it 'returns the sum of those transactions' do
        allow(account.budget).to receive(:current_cycle).and_return(cycle)
        expect(account.spent_this_cycle).to eq(transaction_2.amount)
      end
    end
  end
end
