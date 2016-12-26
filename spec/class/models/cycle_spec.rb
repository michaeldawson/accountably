require 'spec_helper'

RSpec.describe Cycle do
  let(:cycle) { Cycle.new(start_date, length) }

  describe '#current?' do
    let(:length) { 'fortnightly' }

    context "when we're in the middle of this cycle" do
      let(:start_date) { 1.week.ago }

      it 'returns true' do
        expect(cycle).to be_current
      end
    end

    context 'when this cycle is in the past' do
      let(:start_date) { 4.weeks.ago }

      it 'returns false' do
        expect(cycle).not_to be_current
      end
    end
  end

  describe '#end_date' do
    context 'for a weekly cycle starting today' do
      let(:start_date) { Time.current.to_date }
      let(:length) { 'weekly' }

      it 'returns a week from now' do
        expect(cycle.end_date).to eq((Time.current + 1.week).to_date)
      end
    end
  end

  describe '#days_remaining' do
    context 'when the cycle is in the past' do
      let(:start_date) { 1.month.ago }
      let(:length) { 'fortnightly' }

      it 'returns 0' do
        expect(cycle.days_remaining).to eq(0)
      end
    end

    context 'when the cycle is current' do
      let(:start_date) { 1.day.ago }
      let(:length) { 'fortnightly' }

      it 'returns the number of days to go in the cycle' do
        expect(cycle.days_remaining).to eq(13)
      end
    end
  end

  describe '#percent_through_period' do
    context 'when the cycle is in the past' do
      let(:start_date) { 1.month.ago }
      let(:length) { 'fortnightly' }

      it 'returns 100' do
        expect(cycle.percent_through_period).to eq(100)
      end
    end

    context 'when the cycle is current' do
      let(:start_date) { 1.day.ago }
      let(:length) { 'fortnightly' }

      it 'returns the percent through the period' do
        expect(cycle.percent_through_period).to eq(93)
      end
    end
  end
end
