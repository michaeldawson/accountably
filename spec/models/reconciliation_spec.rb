require 'spec_helper'

RSpec.describe Reconciliation do
  let(:reconciliation) { Reconciliation.new(reconcilation_params) }

  describe '#perform' do
    context 'with an expense' do
      let!(:budget) { FactoryGirl.create(:budget) }
      let!(:account1) { FactoryGirl.create(:account) }
      let!(:account2) { FactoryGirl.create(:account) }
      let!(:expense) { FactoryGirl.create(:expense_transaction, account: account1, amount: 1.0) }

      let(:reconcilation_params) {
        {
          expense_id: expense.id,
          account_id: account2.id,
        }
      }

      it 'increments the previous account' do
        expect { reconciliation.perform }.to change { account1.reload.balance.dollars }.by(1)
      end

      it 'decrements the new account' do
        expect { reconciliation.perform }.to change { account2.reload.balance.dollars }.by(-1)
      end
    end
  end
end
