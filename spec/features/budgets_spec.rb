require 'spec_helper'

feature 'Budgets' do
  describe 'Creating a new budget' do
    context 'when logged in as a user without a budget' do
      before :each do
        @user = FactoryGirl.create(:user)
        login_as @user
      end

      scenario "I'm taken to the new budget page, where I can setup the budget" do
        visit root_path

        expect(page).to have_content 'New budget'
      end
    end
  end
end
