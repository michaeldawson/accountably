require 'spec_helper'

RSpec.describe Bank::Account, type: :model do
  let(:bank_account) { Bank::Account.new(valid_attributes) }
  let(:valid_attributes) {
    {
      budget: Budget.new,
      adapter_type: 'NAB'
    }
  }
  describe '#adapter' do
    context 'with a valid adapter type' do
      it 'returns an instance of the bank adapter' do
        expect(bank_account.adapter).to eq(Bank::Adapter::NAB)
      end
    end
  end
end
