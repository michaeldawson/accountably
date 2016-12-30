require 'spec_helper'

RSpec.describe Transaction::Income, type: :model do
  let(:expense) { Transaction::Income.new(valid_attributes) }
  let(:valid_attributes) {
    {
      bucket: Bucket.new,
      effective_date: Time.current,
      description: "Hey! I'm income.",
      amount: 100.0
    }
  }

  describe 'Callbacks' do
    before :each do
      valid_attributes.merge!(
        source: FactoryGirl.build_stubbed(:bank_account),
        bucket: FactoryGirl.build(:bucket),
      )
    end

    it 'increments the bucket balance on create' do
      expect {
        expense.save!
      }.to change {
        expense.bucket.balance
      }.by(100.0)
    end
  end
end
