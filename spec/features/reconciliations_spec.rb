require 'spec_helper'

feature 'Reconcilation', js: true do
  context 'with an uncategorised transaction' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:budget) { FactoryGirl.create(:budget, user: user) }
    let!(:other_account) { budget.accounts.first }
    let(:transaction_params) {
      {
        description: 'Some unreconciled transaction',
        account: budget.default_account,
        amount: 1000
      }
    }
    let!(:transaction) { FactoryGirl.create(:expense_transaction, **transaction_params) }

    scenario 'a user can reconcile the transaction to another account' do
      visit account_path(budget.default_account)
      click_on transaction.description

      expect(page).to have_content('Reconcile')
      select other_account.name, from: 'Account'

      expect {
        click_on 'Reconcile!'
        expect(page).to have_content('Transaction was reconciled')
      }.to change {
        other_account.reload.balance
      }.by(-transaction.amount)
    end
  end
end
