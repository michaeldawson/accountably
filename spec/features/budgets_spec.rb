require 'spec_helper'

feature 'Budgets', js: true do
  describe 'Creating a new budget' do
    context 'when logged in as a user without a budget' do
      before :each do
        @user = FactoryGirl.create(:user)
        login_as @user
      end

      scenario "I'm taken to the new budget page, where I can setup the budget" do
        visit root_path

        expect(page).to have_content 'Setup budget'

        select 'weekly', from: 'Cycle length'

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
