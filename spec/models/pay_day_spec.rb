require 'spec_helper'

RSpec.describe PayDay do
  let(:pay_day) { PayDay.new(budget, date) }
  let(:budget) { Budget.new }
  let(:date) { Time.current }

  describe '#apply!' do
  end
end
