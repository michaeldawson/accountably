require 'spec_helper'

RSpec.describe Budget, type: :model do
  let(:budget) { Budget.new(valid_attributes) }
  let(:valid_attributes) {
    {
      user: User.new,
      cycle_length: 'weekly',
      buckets: [Bucket.new(name: 'Rent', amount: 1000)]
    }
  }

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
end