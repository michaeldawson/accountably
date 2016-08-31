require 'spec_helper'

feature 'Budgets', js: true do
  describe 'Creating a new budget' do
    context 'when logged in as a user without a budget' do
      before :each do
        @user = FactoryGirl.create(:user)
        login_as @user
      end

      scenario "I can set up a budget, with a defined cycle length, and a pay day" do
        payday = Time.current.to_date

        visit root_path

        expect(page).to have_content 'Setup budget'

        select 'weekly', from: 'Cycle length'
        fill_in 'First pay day', with: payday.strftime("%d/%m/%Y")

        fill_in 'Name', with: 'Rent'
        fill_in 'Amount', with: 100

        click_on 'Save'

        expect(page).to have_content('Budget was saved')

        budget = Budget.last
        bucket = budget.buckets.last

        expect(budget.user).to eq(@user)
        expect(bucket.name).to eq('Rent')
        expect(bucket.amount).to eq(100)
      end
    end
  end
end
