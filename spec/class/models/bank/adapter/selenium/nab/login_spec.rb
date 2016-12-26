require 'spec_helper'

RSpec.describe Bank::Adapter::Selenium::NAB::Login do
  let(:login) { described_class.new(**valid_attributes) }
  let(:valid_attributes) {
    {
      session: session,
      bank_login: bank_login
    }
  }
  let(:session) { spy(:capybara_session) }

  describe '#login' do
    context 'when the bank_login model has credentials' do
      let(:bank_login) { double(:bank_login, credentials: { foo: :bar }) }

      it 'returns true' do
        assert login.login == true
      end
    end

    context "when the bank_login model doesn't have credentials" do
      let(:bank_login) { double(:bank_login, credentials: nil) }

      it 'raises an error' do
        expect {
          login.login
        }.to raise_error('This login lacks security credentials')
      end
    end
  end
end
