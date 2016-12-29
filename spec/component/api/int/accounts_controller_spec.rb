require 'spec_helper'

RSpec.describe API::Int::AccountsController, type: :controller do
  describe '#index' do
    context 'when logged in as a user' do
      let!(:user) { FactoryGirl.create(:user) }
      before { allow(controller).to receive(:current_user) { user } }

      context 'with accounts' do
        let!(:budget) { FactoryGirl.create(:budget, user: user) }
        let!(:users_account) { FactoryGirl.create(:account, name: 'Foobars', budget: budget) }
        let!(:other_account) { FactoryGirl.create(:account) }

        it "returns the user's accounts" do
          get :index
          expect(response).to be_success

          response_body = JSON.parse(response.body)
          expect(response_body).to eq(
            [
              {
                'id' => users_account.id,
                'name' => 'Foobars',
                'amount' => 1
              }
            ],
          )
        end
      end

      context 'with no current budget' do
        it 'returns an empty array' do
          get :index
          expect(response).to be_success

          response_body = JSON.parse(response.body)
          expect(response_body).to eq([])
        end
      end
    end
  end

  describe '#update' do
    context 'when logged in as a user' do
      let!(:user) { FactoryGirl.create(:user) }
      before { allow(controller).to receive(:current_user) { user } }

      context 'with accounts' do
        let!(:budget) { FactoryGirl.create(:budget, user: user) }
        let!(:users_account) { FactoryGirl.create(:account, budget: budget) }

        scenario 'I can update the account amount' do
          expect {
            put :update, params: { id: users_account.id, account: { amount: 90 } }
          }.to change {
            users_account.reload.amount
          }.to(9000)
        end
      end
    end
  end
end
