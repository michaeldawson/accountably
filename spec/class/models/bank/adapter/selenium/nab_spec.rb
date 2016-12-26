require 'spec_helper'

RSpec.describe Bank::Adapter::Selenium::NAB do
  let(:nab_adapter) { Bank::Adapter::Selenium::NAB.new(bank_login) }
  let(:bank_login) { FactoryGirl.create(:bank_login) }

  describe '#reconcile' do
    let(:bank_account) { FactoryGirl.create(:bank_account) }
    let(:account_adapter) { instance_double(Bank::Adapter::Selenium::NAB::Account, reconcile: true) }
    let(:login_adapter) { instance_double(Bank::Adapter::Selenium::NAB::Login, login: true) }

    before do
      allow(Capybara::Session).to receive(:new).and_return(spy(:capybara_session))
      allow(Bank::Adapter::Selenium::NAB::Login).to receive(:new).and_return(login_adapter)
      allow(Bank::Adapter::Selenium::NAB::Account).to receive(:new).and_return(account_adapter)
      allow(account_adapter).to receive(:reconcile)
    end

    it "updates the 'last_reconciled' field on the bank account" do
      expect {
        nab_adapter.reconcile(bank_account)
      }.to change {
        bank_account.reload.last_reconciled
      }.from(nil)
    end
  end
end
