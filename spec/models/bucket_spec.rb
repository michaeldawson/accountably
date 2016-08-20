require 'spec_helper'

RSpec.describe Bucket, type: :model do
  let(:bucket) { Bucket.new(valid_attributes) }
  let(:valid_attributes) {
    {
      budget: Budget.new
    }
  }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(bucket).to be_valid
    end

    it 'should not be valid without a budget' do
      valid_attributes[:budget] = nil
      expect(bucket).not_to be_valid
    end
  end
end
