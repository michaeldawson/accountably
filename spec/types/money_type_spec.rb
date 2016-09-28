# To test the money type, we test a Transaction::Expense, which mounts :amount as a money type. Not exactly a purist
# approach, but one that affords the coverage that we need!

RSpec.describe MoneyType do
  let(:expense) { Transaction::Expense.new(amount: amount) }

  describe '#cast' do
    context 'with an amount that includes a dollar sign' do
      let(:amount) { '$100' }

      it 'serializes amount as a MoneyType' do
        expect(expense.amount).to eq(10000)
      end
    end
  end

  describe '#serialize' do
    context 'with an amount that includes a dollar sign' do
      let(:expense) { FactoryGirl.create(:expense_transaction, amount: amount) }
      let(:amount) { 100.0 }

      it 'serializes amount as a MoneyType' do
        expense.reload
        expect(expense.amount).to eq(100.0)
      end
    end
  end
end
