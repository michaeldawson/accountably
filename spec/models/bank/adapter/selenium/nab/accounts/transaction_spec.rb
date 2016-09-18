require 'spec_helper'
require 'bank/adapter/selenium/nab/account/transaction'

RSpec.describe Bank::Adapter::Selenium::NAB::Account::Transaction do
  let(:transaction) { Bank::Adapter::Selenium::NAB::Account::Transaction.new(bank_account, raw_data) }
  let(:bank_account) { FactoryGirl.build_stubbed(:bank_account) }

  describe '#parse!' do
    context 'with valid raw data' do
      context 'with valid debit raw data' do
        let(:raw_data) { ['17 Sep 16', 'EFTPOS DEBIT', '11.99 DR', '', '57.88 DR'] }

        context "when there isn't already a transaction for those details" do
          it 'creates a valid transaction' do
            expect{
              transaction.parse!
            }.to change {
              ::Transaction.count
            }.by(1)
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
    end
  end
end
