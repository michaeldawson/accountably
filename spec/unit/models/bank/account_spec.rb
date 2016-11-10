require 'spec_helper'

RSpec.describe Bank::Account, type: :model do
  let(:bank_account) { Bank::Account.new(valid_attributes) }
  let(:bank_login) { Bank::Login.new }

  let(:valid_attributes) {
    {
      login: bank_login
    }
  }
  describe '#reconcile' do
    context 'with a valid adapter type' do
      it 'fetches recent transactions for the account' do
        expect(bank_login).to receive(:reconcile).with(bank_account, since: nil)
        bank_account.reconcile
      end
    end
  end
end
