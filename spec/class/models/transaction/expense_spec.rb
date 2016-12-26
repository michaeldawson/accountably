require 'spec_helper'

RSpec.describe Transaction::Expense, type: :model do
  let(:expense) { Transaction::Expense.new(valid_attributes) }
  let(:valid_attributes) {
    {
      account: Account.new,
      effective_date: Time.current,
      description: "Hey! I'm an expense.",
      amount: 100,
      source: Bank::Account.new
    }
  }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(expense).to be_valid
    end

    it 'should not be valid without a account' do
      valid_attributes[:account] = nil
      expect(expense).not_to be_valid
    end

    it 'should not be valid without a date' do
      valid_attributes[:effective_date] = nil
      expect(expense).not_to be_valid
    end

    it 'should not be valid without a description' do
      valid_attributes[:description] = nil
      expect(expense).not_to be_valid
    end

    it 'should not be valid without an amount' do
      valid_attributes[:amount] = nil
      expect(expense).not_to be_valid
    end
  end

  describe 'Callbacks' do
    before :each do
      valid_attributes.merge!(
        source: FactoryGirl.build_stubbed(:bank_account),
        account: FactoryGirl.build(:account)
      )
    end

    it 'decrements the account balance on create' do
      expect {
        expense.save!
      }.to change {
        expense.account.balance
      }.by(-100)
    end
  end

  describe 'Scopes' do
    describe '#unreconciled' do
      let(:budget) { FactoryGirl.create(:budget) }
      let(:default_account) { budget.default_account }
      let(:other_account) { FactoryGirl.create(:account, budget: budget) }
      let!(:unreconciled_transaction) { FactoryGirl.create(:expense_transaction, account: default_account) }
      let!(:reconciled_transaction) { FactoryGirl.create(:expense_transaction, account: other_account) }

      it "returns transactions for which the account is the budget's default account" do
        expect(budget.expenses.unreconciled).to eq([unreconciled_transaction])
      end
    end
  end
end
