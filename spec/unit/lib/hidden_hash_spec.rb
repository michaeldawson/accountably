require 'spec_helper'

RSpec.describe HiddenHash do
  describe '.new_from_hash' do
    let(:hash) { { a: :b } }
    let(:hidden_hash) { HiddenHash.new_from_hash(hash) }

    it 'creates a hash-like object' do
      expect(hidden_hash[:a]).to eq(:b)
    end

    it 'hides data from inspection' do
      expect(hidden_hash.to_s).to eq('(hidden)')
      expect(hidden_hash.inspect).to eq('(hidden)')
    end
  end
end
