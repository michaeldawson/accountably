require 'spec_helper'

feature 'Budgets', js: true do
  describe 'setup' do
    context 'when logged in as a user without a budget' do
      before :each do
        @user = FactoryGirl.create(:user)
        login_as @user
      end

      xscenario 'I can set up a budget, with a defined cycle length, and a pay day. Balances are applied to accounts.' do
        payday = Time.current.to_date

        visit root_path

        expect(page).to have_content 'Setup budget'

        select 'weekly', from: 'Cycle length'
        fill_in 'Total amount', with: 100
        fill_in 'First pay day', with: payday.strftime("%d/%m/%Y")

        fill_in 'Name', with: 'Rent'
        fill_in 'Amount', with: 100

        click_on 'Save'

        expect(page).to have_content('Budget was saved')

        budget = Budget.last
        account = budget.buckets.last

        expect(budget.user).to eq(@user)
        expect(account.name).to eq('Rent')
        expect(account.amount).to eq(100.0)

        expect(account.balance).to eq(100.0)
      end
    end

    context 'when logged in as a user with a budget' do
      before :each do
        @user = FactoryGirl.create(:user)
        @budget = FactoryGirl.create(:budget, user: @user)
        login_as @user
      end

      scenario "the user can't create another budget" do
        visit new_budget_path
        expect(page).not_to have_content 'Setup budget'
      end
    end
  end
end
