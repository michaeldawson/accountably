require 'spec_helper'

RSpec.describe Bank::Adapter::Selenium::NAB::Account do
  let(:account) { described_class.new(**valid_attributes) }
  let(:valid_attributes) {
    {
      session: session,
      bank_account: bank_account
    }
  }
  let(:session) { double(:capybara_session) }

  describe '#reconcile' do
    let(:bank_account) { FactoryGirl.create(:bank_account, name: 'My account') }
    let(:transaction_parser) { double(:transaction) }
    let(:stubbed_transaction_row_element) { double(:capybara_node) }

    before do
      allow(session).to receive(:find)
      allow(session).to receive(:within).and_yield
      allow(session).to receive(:click_link)
      allow(session).to receive(:all).with('#transactionHistoryTable tbody tr')
        .and_return([stubbed_transaction_row_element])
      allow(stubbed_transaction_row_element).to receive(:all).with('td')
        .and_return([double(:capybara_node, text: 'Some text')])
      allow(session).to receive(:has_css?).and_return(false)
    end

    it 'requests that transactions be parsed' do
      allow(Bank::Adapter::Selenium::NAB::Account::Transaction)
        .to receive(:new)
        .and_return(transaction_parser)

      expect(transaction_parser).to receive(:parse!)

      account.reconcile
    end
  end
end
