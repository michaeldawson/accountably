require 'spec_helper'

RSpec.describe Bank::Account, type: :model do
  let(:bank_account) { Bank::Account.new(valid_attributes) }
  let(:bank_login) { Bank::Login.new }

  let(:valid_attributes) {
    {
      login: bank_login,
      adapter_type: 'NAB'
    }
  }
  describe '#reconcile' do
    context 'with a valid adapter type' do
      let(:adapter) { Bank::Adapter::Selenium::NAB.new(bank_login) }

      before :each do
        allow(Bank::Adapter::Selenium::NAB).to receive(:new).and_return(adapter)
      end

      it 'fetches recent transactions for the account' do
        expect(adapter).to receive(:reconcile).with(bank_account)
        bank_account.reconcile
      end
    end
  end
end
