require 'spec_helper'

feature 'Bank accounts' do
  context 'when logged in as a user' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:budget) { FactoryGirl.create(:budget, user: user) }

    before { login_as user }

    context 'with bank accounts' do
      let!(:bank_account) { FactoryGirl.create(:bank_account, name: 'Test account', budget: budget) }

      scenario 'I can view my accounts' do
        visit bank_accounts_path
        expect(page).to have_content('Test account')
      end
    end
  end
end
