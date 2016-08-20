require 'spec_helper'

feature 'Accounts' do
  describe 'Viewing accounts' do
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
  end

  describe 'Adding accounts' do
    context 'when logged in' do
      before :each do
        @user = FactoryGirl.create(:user)
        login_as @user
      end

      scenario 'I can add a new account' do
        visit new_account_path
        fill_in 'Name', with: 'My new account'
        click_on 'Create Account'

        expect(page).to have_content('Account created')
      end
    end
  end
end
