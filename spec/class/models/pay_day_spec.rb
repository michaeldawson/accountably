require 'spec_helper'

RSpec.describe PayDay do
  let(:pay_day) { PayDay.new(valid_attributes) }
  let(:valid_attributes) {
    {
      budget: FactoryGirl.build(:budget),
      effective_date: Time.current
    }
  }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(pay_day).to be_valid
    end

    it 'should not be valid with another pay day for the same budget on that day' do
      pay_day.save!
      expect(PayDay.new(valid_attributes)).not_to be_valid
    end
  end

  describe '#apply!' do
    context 'with a budget with buckets' do
      before :each do
        pay_day.save!
        pay_day.budget.buckets.create(FactoryGirl.attributes_for(:bucket))
      end

      it 'creates income transactions for all buckets' do
        expect {
          pay_day.apply!
        }.to change {
          Transaction::Income.count
        }.by(1)
      end
    end
  end
end
