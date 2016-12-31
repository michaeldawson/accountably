require 'spec_helper'

feature 'Budgets', js: true do
  describe 'setup' do
    context 'when logged in as a user without a budget' do
      let!(:user) { FactoryGirl.create(:user) }
      before { login_as user }

      scenario 'Step 1: I can set up a budget, with a defined cycle length, and a pay day.' do
        payday = Time.current.to_date

        visit root_path

        expect(page).to have_css('.mt-step-col.done', text: 'BASICS')

        select 'weekly', from: 'Cycle length'
        fill_in 'Total amount', with: 100
        fill_in 'First pay day', with: payday.strftime("%d/%m/%Y")

        click_on 'Next'

        expect(page).to have_css('.mt-step-col.done', text: 'BANK ACCOUNTS')

        budget = Budget.last

        expect(budget.user).to eq(user)
        expect(budget.target).to eq(100.0)
        expect(budget.first_pay_day).to eq(payday)
      end
    end

    context 'when logged in as a user with a budget' do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:budget) { FactoryGirl.create(:budget, user: user) }
      before { login_as user }

      scenario 'Step 1: I can link a bank account' do
        visit edit_budget_path
        expect(page).to have_css('.mt-step-col.done', text: 'BANK ACCOUNTS')
      end
    end
  end
end
