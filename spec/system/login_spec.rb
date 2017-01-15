feature 'Logging in', js: true do
  context 'with a user account' do
    before :each do
      @user = FactoryGirl.create(:user, password: 'foobar')
    end

    scenario 'I can login' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'foobar'

      click_on 'Log in'
      expect(page).to have_content('BASICS')
    end
  end
end
