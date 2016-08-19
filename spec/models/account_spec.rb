require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { Account.new(valid_attributes) }
  let(:valid_attributes) {
    {
      user: User.new
    }
  }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(account).to be_valid
    end

    it "shouldn't be valid without a user" do
      valid_attributes[:user] = nil
      expect(account).not_to be_valid
    end
  end
end
