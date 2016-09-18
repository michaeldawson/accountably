require 'spec_helper'

RSpec.describe Budget, type: :model do
  let(:budget) { Budget.new(valid_attributes) }
  let(:valid_attributes) {
    {
      user: FactoryGirl.build_stubbed(:user),
      cycle_length: 'weekly',
      first_pay_day: Time.current.to_date,
      accounts: accounts
    }
  }
  let(:accounts) { [Account.new(name: 'Rent', amount: 1000)] }

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

    it 'should not be valid without at least one account' do
      valid_attributes[:accounts] = []
      expect(budget).not_to be_valid
    end
  end

  describe '#default_account' do
    context 'when the budget has a default account' do
      before :each do
        budget.save!
      end

      let!(:default_account) { FactoryGirl.create(:account, budget: budget, default: true) }

      it 'returns that account' do
        expect(budget.default_account).to eq(default_account)
      end
    end

    context "when the budget doesn't have a default account" do
      before :each do
        budget.save!
      end

      it 'creates a new account' do
        expect {
          budget.default_account
        }.to change {
          Account.count
        }.by(1)

        account = Account.last
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
          expect(budget.current_cycle).to eq(Time.current.to_date..(Time.current.to_date + 1.week))
        end
      end

      context 'when the last pay day is some date in the past' do
        let(:date_in_the_past) { Time.current.to_date - 3.weeks - 2.days }

        before :each do
          valid_attributes[:first_pay_day] = date_in_the_past
          budget.save!
          expect(budget.pay_days.map(&:effective_date)).to eq [date_in_the_past]
        end

        it 'returns the period from the last pay day onwards' do
          expect(budget.current_cycle).to eq(date_in_the_past..(date_in_the_past + 1.week))
        end
      end
    end
  end
end
