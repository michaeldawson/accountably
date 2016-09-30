require 'spec_helper'

RSpec.describe TransactionPattern, type: :model do
  let(:transaction_pattern) { TransactionPattern.new(valid_attributes) }
  let(:valid_attributes) {
    {
      account: Account.new,
      pattern: 'Some string of words'
    }
  }

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(transaction_pattern).to be_valid
    end

    it "isn't valid without an account" do
      valid_attributes[:account] = nil
      expect(transaction_pattern).not_to be_valid
    end

    it "isn't valid without a pattern" do
      valid_attributes[:pattern] = nil
      expect(transaction_pattern).not_to be_valid
    end
  end

  describe '#applies_to?' do
    let(:transaction) { Transaction.new(description: description) }

    context 'for a transaction description that fully matches' do
      let(:description) { 'Some string of words' }
      it { assert transaction_pattern.applies_to?(transaction) }
    end

    context 'for a transaction description that contains the pattern' do
      let(:description) { 'Some string of words and some other words' }
      it { assert transaction_pattern.applies_to?(transaction) }
    end

    context "for a transaction description that doesn't contain the pattern" do
      let(:description) { 'Some string of pearls' }
      it { assert !transaction_pattern.applies_to?(transaction) }
    end
  end
end
