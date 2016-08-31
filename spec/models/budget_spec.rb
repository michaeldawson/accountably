require 'spec_helper'

RSpec.describe Budget, type: :model do
  let(:budget) { Budget.new(valid_attributes) }
  let(:valid_attributes) {
    {
      user: User.new,
      cycle_length: 'weekly',
      first_pay_day: Time.current.to_date,
      buckets: buckets
    }
  }
  let(:buckets) { [Bucket.new(name: 'Rent', amount: 1000)] }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(budget).to be_valid
    end

    it 'should not be valid without a user' do
      valid_attributes[:user] = nil
      expect(budget).not_to be_valid
    end

    it 'should not be valid without a cycle length' do
      valid_attributes[:cycle_length] = nil
      expect(budget).not_to be_valid
    end

    it 'should not be valid with an invalid cycle length' do
      valid_attributes[:cycle_length] = 'foobar'
      expect(budget).not_to be_valid
    end

    it 'should not be valid without at least one bucket' do
      valid_attributes[:buckets] = []
      expect(budget).not_to be_valid
    end
  end

  describe '#apply!' do
    let(:buckets) {
      [
        Bucket.new(name: 'Rent', amount: 1000),
        Bucket.new(name: 'Cocaine', amount: 2000)
      ]
    }

    it 'increments each bucket by its amount' do
      buckets.each do |bucket|
        expect(bucket).to receive(:apply_budgeted_amount!)
      end

      budget.apply!
    end
  end
end
