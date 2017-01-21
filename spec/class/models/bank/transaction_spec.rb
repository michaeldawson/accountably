require 'spec_helper'
require 'bank/transaction'

RSpec.describe Bank::Transaction do
  let(:transaction) { described_class.new(transaction_data: transaction_data, bank_account: bank_account) }
  let(:budget) { FactoryGirl.create(:budget) }
  let(:bank_login) { FactoryGirl.create(:bank_login, budget: budget) }
  let(:bank_account) { FactoryGirl.create(:bank_account, login: bank_login) }

  describe '#parse!' do
    context 'with valid raw transaction_data' do
      context 'for a debit' do
        let(:transaction_data) {
          {
            effective_date: Date.parse('17 Sep 16'),
            description: 'EFTPOS DEBIT',
            amount: Money.new(-57.88),
          }
        }

        context "when there isn't already a transaction for those details" do
          it 'creates a valid transaction' do
            expect {
              transaction.parse!
            }.to change {
              ::Transaction::Expense.count
            }.by(1)

            transaction = Transaction::Expense.last
            expect(transaction.effective_date).to eq(DateTime.parse('17/09/2016').in_time_zone)
            expect(transaction.amount).to eq(57.88)
            expect(transaction.description).to eq('EFTPOS DEBIT')
            expect(transaction.source_id).to eq(bank_account.id)
          end

          context 'when the budget has a transaction pattern that matches the transaction description' do
            let!(:bucket) { FactoryGirl.create(:bucket, budget: budget) }

            let!(:transaction_pattern) {
              FactoryGirl.create(:transaction_pattern, bucket: bucket, pattern: 'EFTPOS DEBIT')
            }

            it 'creates a transaction for that account' do
              transaction.parse!
              expense = Transaction::Expense.last
              expect(expense.bucket_id).to eq(bucket.id)
            end
          end
        end

        context 'when there is already a transaction for those details' do
          before { transaction.parse! }

          it "doesn't create a duplicate transaction" do
            expect {
              transaction.parse!
            }.not_to change {
              ::Transaction.count
            }
          end
        end
      end

      context 'for a > $1k debit' do
        let(:transaction_data) {
          {
            effective_date: Date.parse('17 Sep 16'),
            description: 'EFTPOS DEBIT',
            amount: Money.new(-1199.55),
          }
        }

        it 'creates a valid transaction' do
          expect {
            transaction.parse!
          }.to change {
            ::Transaction::Expense.count
          }.by(1)

          transaction = Transaction::Expense.last
          expect(transaction.amount).to eq(119_955)
        end
      end
    end
  end
end
