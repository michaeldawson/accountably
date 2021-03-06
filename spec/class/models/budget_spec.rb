require 'spec_helper'

RSpec.describe Budget, type: :model do
  let(:budget) { Budget.new(valid_attributes) }
  let(:valid_attributes) {
    {
      user: FactoryGirl.build_stubbed(:user),
      target: 100.0,
      cycle_length: 'weekly',
      first_pay_day: Time.current.to_date,
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

    it 'should not be valid without a target amount' do
      valid_attributes[:target] = nil
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
  end

  describe '#default_bucket' do
    context 'when the budget has a default account' do
      before :each do
        budget.save!
      end

      let!(:default_bucket) { FactoryGirl.create(:bucket, budget: budget, default: true) }

      it 'returns that account' do
        expect(budget.default_bucket).to eq(default_bucket)
      end
    end

    context "when the budget doesn't have a default account" do
      before :each do
        budget.save!
      end

      it 'creates a new account' do
        expect {
          budget.default_bucket
        }.to change {
          Bucket.count
        }.by(1)

        account = Bucket.last
        expect(account.amount).to eq(0)
        expect(account.balance).to eq(0)
        expect(account.name).to eq('Uncategorised')
        assert account.default
      end
    end
  end

  describe '#current_cycle' do
    context 'when the cycle length is weekly' do
      context 'when the first pay day is today' do
        it 'returns the period from today to next week' do
          start_date = Time.current.to_date
          end_date = Time.current.to_date + 1.week

          budget.save!
          expect(budget.current_cycle.date_range).to eq(start_date..end_date)
        end
      end

      context 'when the last pay day is some date in the past' do
        let(:date_in_the_past) { Time.current.to_date - 1.week - 2.days }

        before :each do
          valid_attributes[:first_pay_day] = date_in_the_past
          budget.save!
          budget.create_first_pay_day
          expect(budget.pay_days.map(&:effective_date)).to eq [date_in_the_past]
        end

        it 'creates a new payday, so that the current cycle is current' do
          start_date = date_in_the_past
          end_date = date_in_the_past + 1.week

          expect {
            budget.current_cycle
          }.to change {
            PayDay.count
          }.by(1)

          expect(budget.current_cycle).to be_current
        end
      end
    end
  end

  describe '#create_first_pay_day' do
    context 'when there is no previous pay day' do
      it 'creates a new pay day on the date of the first pay day' do
        budget.save!

        expect {
          budget.create_first_pay_day
        }.to change {
          PayDay.count
        }.by(1)

        pay_day = PayDay.last
        expect(pay_day.effective_date).to eq(budget.first_pay_day)
      end
    end
  end
end
