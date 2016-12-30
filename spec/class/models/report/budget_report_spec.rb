require 'spec_helper'

RSpec.describe Report::BudgetReport do
  let(:report) { Report::BudgetReport.new(budget, cycle) }
  let(:budget) { FactoryGirl.build(:budget) }
  let(:bucket) { FactoryGirl.build(:bucket, budget: budget) }
  let(:cycle) { Cycle.new(1.week.ago, 'fortnightly') }

  describe '#spend' do
    context 'with expenses in this cycle and outside of this cycle' do
      before { bucket.save! }

      let!(:expense_1) {
        FactoryGirl.create(:expense_transaction, bucket: bucket, effective_date: cycle.start_date - 1.day, amount: 10)
      }
      let!(:expense_2) {
        FactoryGirl.create(:expense_transaction, bucket: bucket, effective_date: cycle.start_date + 1.day, amount: 12)
      }

      it 'returns the amount of the expense in the cycle' do
        expect(report.spend).to eq(12)
      end
    end
  end

  describe '#balance' do
    context "when the cycle isn't current" do
      before do
        allow(cycle).to receive(:current?).and_return(false)
      end

      it { expect { report.balance }.to raise_error(NotImplementedError) }
    end

    context 'when the cycle is current' do
      context 'when the budget bucket have a negative balance' do
        before do
          bucket.balance = -100
          bucket.save
        end

        it { expect(report.balance).to eq(-100) }
      end
    end
  end
end
