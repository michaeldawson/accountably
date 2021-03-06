require 'spec_helper'

RSpec.describe Bank::Login, type: :model do
  let(:bank_login) { Bank::Login.new(valid_attributes) }
  let(:valid_attributes) {
    {
      budget: FactoryGirl.build_stubbed(:budget),
      credentials: {
        user_id: 'abc123',
        password: 'foobar'
      },
      adapter_type: 'NAB'
    }
  }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(bank_login).to be_valid
    end

    it "isn't valid without an adapter type" do
      valid_attributes[:adapter_type] = nil
      expect(bank_login).not_to be_valid
    end

    it "isn't valid without a budget" do
      valid_attributes[:budget] = nil
      expect(bank_login).not_to be_valid
    end
  end

  describe '#credentials' do
    it 'encrypts before saving' do
      bank_login.save!

      saved_credentials = bank_login.credentials_before_type_cast
      expect(saved_credentials).not_to eq(bank_login.credentials.to_json)
    end
  end
end
