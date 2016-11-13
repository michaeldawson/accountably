require 'spec_helper'

feature 'Reconcilation', js: true do
  let!(:user) { FactoryGirl.create(:user) }

  before :each do
    login_as user
  end

  context 'with an uncategorised transaction' do
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

    scenario 'a user can view unreconciled transactions' do
      visit reconcile_accounts_path
      expect(page).to have_content('Some unreconciled transaction')
    end

    scenario 'a user can reconcile the transaction to another account' do
      visit account_path(budget.default_account)
      click_on transaction.description

      select other_account.name, from: 'Account'

      expect {
        click_on 'Reconcile!'
        expect(page).to have_content('Transaction was reconciled')
      }.to change {
        other_account.reload.balance
      }.by(-transaction.amount)

      expect(TransactionPattern.count).to be_zero
    end

    scenario 'setting a matching pattern creates a new transaction pattern' do
      visit transaction_expense_path(transaction)

      select other_account.name, from: 'Account'
      check 'Save matching pattern'

      expect {
        click_on 'Reconcile!'
        expect(page).to have_content('Transaction was reconciled')
      }.to change {
        TransactionPattern.count
      }.by(1)
    end
  end
end
