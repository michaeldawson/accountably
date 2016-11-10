require 'spec_helper'
require 'bank/adapter/selenium/nab/account/transaction'

RSpec.describe Bank::Adapter::Selenium::NAB::Account::Transaction do
  let(:transaction) { Bank::Adapter::Selenium::NAB::Account::Transaction.new(transaction_attributes) }
  let(:transaction_attributes) { { raw_data: raw_data, bank_account: bank_account } }
  let(:bank_account) { FactoryGirl.build_stubbed(:bank_account) }

  describe '#parse!' do
    context 'with valid raw data' do
      context 'for a debit' do
        let(:raw_data) { ['17 Sep 16', 'EFTPOS DEBIT', '11.99 DR', '', '57.88 DR'] }

        context "when there isn't already a transaction for those details" do
          it 'creates a valid transaction' do
            expect {
              transaction.parse!
            }.to change {
              ::Transaction::Expense.count
            }.by(1)

            transaction = Transaction::Expense.last
            expect(transaction.effective_date).to eq(DateTime.parse('17/09/2016').in_time_zone)
            expect(transaction.amount).to eq(1199)
            expect(transaction.description).to eq('EFTPOS DEBIT')
            expect(transaction.source_id).to eq(bank_account.id)
          end

          context 'when the budget has a transaction pattern that matches the transaction description' do
            let(:account) { FactoryGirl.build_stubbed(:account) }

            before :each do
              transaction_attributes.merge!(
                transaction_patterns: [TransactionPattern.new(account: account, pattern: 'EFTPOS DEBIT')],
              )
            end

            it 'creates a transaction for that account' do
              transaction.parse!
              expense = Transaction::Expense.last
              expect(expense.account_id).to eq(account.id)
            end
          end
        end

        context 'when there is already a transaction for those details' do
          before :each do
            transaction.parse!
          end

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
        let(:raw_data) { ['17 Sep 16', 'EFTPOS DEBIT', '1,199.55 DR', '', '57.88 DR'] }

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
