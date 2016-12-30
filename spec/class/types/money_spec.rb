require 'spec_helper'

RSpec.describe Money do
  describe '.to_cents' do
    context 'with a String argument' do
      it 'correctly parses $0.10' do
        expect(Money.to_cents('$0.10')).to eq 10
      end

      it 'correctly parses $1' do
        expect(Money.to_cents('$1')).to eq 100
      end

      it 'correctly parses $1.10' do
        expect(Money.to_cents('$1.10')).to eq 110
      end

      it 'correctly parses $10' do
        expect(Money.to_cents('$10')).to eq 1000
      end

      it 'correctly parses $1,000.10' do
        expect(Money.to_cents('$1,000.10')).to eq 100010
      end
    end
  end

  describe '#eql?' do
    context 'comparing with an integer' do
      it 'returns true for an equivalent amount in dollars' do
        expect(Money.new(10000)).to eq(100.0)
      end
    end
  end

  describe '#to_json' do
    it 'should return the amount in cents' do
      expect(Money.new(10_000).to_json).to eq('100.0')
    end
  end
end
