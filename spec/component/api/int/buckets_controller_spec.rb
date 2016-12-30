require 'spec_helper'

RSpec.describe API::Int::BucketsController, type: :controller do
  describe '#index' do
    context 'when logged in as a user' do
      let!(:user) { FactoryGirl.create(:user) }
      before { allow(controller).to receive(:current_user) { user } }

      context 'with buckets' do
        let!(:budget) { FactoryGirl.create(:budget, user: user) }
        let!(:users_bucket) { FactoryGirl.create(:bucket, amount: 100.0, name: 'Foobars', budget: budget) }
        let!(:other_bucket) { FactoryGirl.create(:bucket) }

        it "returns the user's buckets" do
          get :index
          expect(response).to be_success

          response_body = JSON.parse(response.body)
          expect(response_body).to eq(
            [
              {
                'id' => users_bucket.id,
                'name' => 'Foobars',
                'amount' => 100
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

      context 'with buckets' do
        let!(:budget) { FactoryGirl.create(:budget, user: user) }
        let!(:users_bucket) { FactoryGirl.create(:bucket, budget: budget) }

        scenario 'I can update the bucket amount' do
          expect {
            put :update, params: { id: users_bucket.id, bucket: { amount: 90 } }
          }.to change {
            users_bucket.reload.amount
          }.to(9000)
        end
      end
    end
  end
end
