require 'spec_helper'

feature 'Bank accounts' do
  context 'with bank accounts' do
    let!(:bank_account) { FactoryGirl.create(:bank_account, name: 'Test account') }
    let(:user) { bank_account.login.budget.user }

    before { login_as user }

    scenario 'I can view my accounts' do
      visit bank_accounts_path
      expect(page).to have_content('Test account')
    end
  end
end
