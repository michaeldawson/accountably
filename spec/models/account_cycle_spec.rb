require 'spec_helper'

RSpec.describe AccountCycle do
  let(:account_spend) { AccountCycle.new(account, cycle) }
  let(:account) { FactoryGirl.build(:account) }
  let(:cycle) { 2.weeks.ago..1.week.ago }

  describe '#spent' do
    context 'with expenses in this cycle and outside of this cycle' do
      before :each do
        account.save!
      end

      let!(:expense_1) {
        FactoryGirl.create(:expense_transaction, account: account, effective_date: cycle.first - 1.day, amount: 100)
      }
      let!(:expense_2) {
        FactoryGirl.create(:expense_transaction, account: account, effective_date: cycle.first + 1.day, amount: 120)
      }

      it 'returns the sum of those transactions' do
        allow(account.budget).to receive(:current_cycle).and_return(cycle)
        expect(account_spend.spent).to eq(expense_2.amount)
      end
    end
  end

  describe '#available' do
    context 'when the account has a positive balance' do
      before :each do
        account.balance = 100
      end

      it { expect(account_spend.available).to eq(account.balance) }
    end

    context 'when the account has a negative balance' do
      before :each do
        account.balance = -100
      end

      it { expect(account_spend.available).to eq(0) }
    end
  end

  describe '#on_track_spend' do
    before :each do
      account.amount = 1000
    end

    context 'when the cycle has finished' do
      it 'returns the full budgeted amount of the account' do
        expect(account_spend.on_track_spend).to eq(account.amount)
      end
    end

    context 'when the cycle is current' do
      let(:cycle) { 2.days.ago..5.days.from_now }

      it 'returns the full budgeted amount of the account' do
        expect(account_spend.on_track_spend).to eq((account.amount.to_f * 2 / 7).round(2))
      end
    end
  end
end
