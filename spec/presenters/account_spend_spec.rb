require 'spec_helper'

RSpec.describe AccountSpend do
  let(:account_spend) { AccountSpend.new(account, cycle) }
  let(:account) { FactoryGirl.create(:account) }
  let(:cycle) { 2.weeks.ago..1.week.ago }

  describe '#spent' do
    context 'with expenses in this cycle and outside of this cycle' do
      let!(:expense_1) {
        FactoryGirl.create(:expense_transaction, account: account, effective_date: cycle.first - 1.day, amount: 100)
      }
      let!(:expense_2) {
        FactoryGirl.create(:expense_transaction, account: account, effective_date: cycle.first + 1.day, amount: 120)
      }

      before :each do
        account.save!
      end

      it 'returns the sum of those transactions' do
        allow(account.budget).to receive(:current_cycle).and_return(cycle)
        expect(account_spend.spent).to eq(expense_2.amount)
      end
    end
  end
end
