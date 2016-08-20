require 'rails_helper'

feature 'Accounts' do
  context 'when logged in' do
    before :each do
      @user = FactoryGirl.create(:user)
      login_as @user
    end

    context 'when the user has accounts' do
      before :each do
        @account = FactoryGirl.create(:account, user: @user)
      end

      scenario 'visiting the accounts index page shows my accounts' do
        visit accounts_path
        expect(page).to have_content 'My accounts'
        expect(page).to have_content(@account.name)
      end
    end
  end

  context 'when not logged in' do
    scenario 'visiting the accounts index page redirects to the sign in page' do
      visit accounts_path

    end
  end
end
