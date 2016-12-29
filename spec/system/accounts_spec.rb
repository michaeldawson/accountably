require 'spec_helper'

feature 'Accounts' do
  context 'when logged in as a user with a budget' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:budget) { FactoryGirl.create(:budget, user: user) }
    let(:account) { FactoryGirl.create(:account, budget: budget) }

    before :each do
      login_as user
    end

    scenario 'I can view the page for a account' do
      visit account_path(account)
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
