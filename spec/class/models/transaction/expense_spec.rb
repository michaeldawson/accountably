require 'spec_helper'

RSpec.describe Transaction::Expense, type: :model do
  let(:expense) { Transaction::Expense.new(valid_attributes) }
  let(:valid_attributes) {
    {
      bucket: Bucket.new,
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

    it 'should not be valid without a bucket' do
      valid_attributes[:bucket] = nil
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
        bucket: FactoryGirl.build(:bucket),
      )
    end

    it 'decrements the bucket balance on create' do
      expect {
        expense.save!
      }.to change {
        expense.bucket.balance
      }.by(-100)
    end
  end

  describe 'Scopes' do
    describe '#unreconciled' do
      let(:budget) { FactoryGirl.create(:budget) }
      let(:default_bucket) { budget.default_bucket }
      let(:other_bucket) { FactoryGirl.create(:bucket, budget: budget) }
      let!(:unreconciled_transaction) { FactoryGirl.create(:expense_transaction, bucket: default_bucket) }
      let!(:reconciled_transaction) { FactoryGirl.create(:expense_transaction, bucket: other_bucket) }

      it "returns transactions for which the bucket is the budget's default bucket" do
        expect(budget.expenses.unreconciled).to eq([unreconciled_transaction])
      end
    end
  end
end
