require 'spec_helper'

RSpec.describe Api::Int::AccountsController, type: :controller do
  describe '#index' do
    context 'when logged in as a user with accounts' do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:budget) { FactoryGirl.create(:budget, user: user) }
      let!(:users_account) { FactoryGirl.create(:account, name: 'Foobars', budget: budget) }
      let!(:other_account) { FactoryGirl.create(:account) }

      before do
        allow(controller).to receive(:current_user) { user }
      end

      it "returns the user's accounts" do
        get :index
        expect(response).to be_success

        response_body = JSON.parse(response.body)
        expect(response_body['data']).to eq(
          [
            {
              'id' => users_account.id.to_s,
              'type' => 'accounts',
              'links' => {
                'self' => "http://test.host/api/int/accounts/#{users_account.id}"
              },
              'attributes' => { 'name' => 'Foobars' },
            }
          ],
        )
      end
    end
  end
end
