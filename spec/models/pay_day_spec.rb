require 'spec_helper'

RSpec.describe PayDay do
  let(:pay_day) { PayDay.new(budget: budget, effective_date: date) }
  let(:budget) { FactoryGirl.build(:budget) }
  let(:date) { Time.current }

  describe '#apply!' do
    context 'with a budget with accounts' do
      before :each do
        pay_day.save!
      end

      it 'creates income transactions for all accounts' do
        expect {
          pay_day.apply!
        }.to change {
          Transaction::Income.count
        }.by(1)
      end
    end
  end
end
