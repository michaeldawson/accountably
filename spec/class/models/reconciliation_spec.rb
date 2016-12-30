require 'spec_helper'

RSpec.describe Reconciliation do
  let(:reconciliation) { Reconciliation.new(reconcilation_params) }

  describe '#perform' do
    context 'with an expense' do
      let!(:budget) { FactoryGirl.create(:budget) }
      let!(:bucket1) { FactoryGirl.create(:bucket) }
      let!(:bucket2) { FactoryGirl.create(:bucket) }
      let!(:expense) { FactoryGirl.create(:expense_transaction, bucket: bucket1, amount: 1.0) }

      let(:reconcilation_params) {
        {
          expense_id: expense.id,
          bucket_id: bucket2.id,
        }
      }

      it 'increments the previous bucket' do
        expect { reconciliation.perform }.to change { bucket1.reload.balance.dollars }.by(1)
      end

      it 'decrements the new bucket' do
        expect { reconciliation.perform }.to change { bucket2.reload.balance.dollars }.by(-1)
      end

      context 'and no matching pattern' do
        before :each do
          reconcilation_params.merge!(save_matching_pattern: '0', matching_pattern: 'String')
        end

        it "doesn't create a transaction pattern for the bucket" do
          expect {
            reconciliation.perform
          }.not_to change {
            TransactionPattern.count
          }
        end
      end

      context 'and a matching pattern' do
        before :each do
          reconcilation_params.merge!(save_matching_pattern: '1', matching_pattern: 'Some pattern')
        end

        it 'creates a transaction pattern for the bucket' do
          expect {
            reconciliation.perform
          }.to change {
            TransactionPattern.count
          }.by(1)

          transaction_pattern = TransactionPattern.last
          expect(transaction_pattern.bucket).to eq(bucket2)
          expect(transaction_pattern.pattern).to eq('Some pattern')
        end
      end
    end
  end
end
