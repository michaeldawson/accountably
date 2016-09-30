require 'spec_helper'

feature 'Accounts' do
  context 'when logged in as a user with a budget' do
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

    scenario 'I can view the page for a account' do
      visit budget_path(@budget)
      click_on 'Things'
      expect(page).to have_css('h3.account')
    end

    scenario 'I can edit a account' do
      visit edit_account_path(account)
      fill_in 'Name', with: 'A new name'
      fill_in 'Amount', with: 1000
      fill_in 'Balance', with: -100

      click_on 'Save'
      expect(page).to have_content('Account was updated')
      account.reload

      expect(account.name).to eq('A new name')
      expect(account.amount).to eq(1000.0)
      expect(account.balance).to eq(-100.0)
    end
  end
end
