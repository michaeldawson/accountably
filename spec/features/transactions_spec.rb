require 'spec_helper'

feature 'Transactions' do
  before :each do
    @budget = FactoryGirl.create(
      :budget,
      accounts: [
        FactoryGirl.create(:account, name: 'Things', amount: 100)
      ]
    )
    @user = FactoryGirl.create(:user)
    login_as @user
  end

  let(:account) { @budget.accounts.first }

  scenario 'I can add transactions to a account' do
    visit account_path(account)
    fill_in 'Description', with: 'A new transaction'
    fill_in 'Amount', with: 100

    expect {
      click_on 'Save'
      expect(page).to have_content 'Transaction was saved'
    }.to change {
      account.reload.balance
    }.by(-100)
  end

  context 'when a account has transactions' do
    before :each do
      @transaction = FactoryGirl.create(:transaction, account: account, description: 'Something wot I bought')
    end

    scenario "I can see them on the account's page" do
      visit account_path(account)
      expect(page).to have_content(@transaction.description)
    end
  end
end
