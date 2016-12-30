FactoryGirl.define do
  factory :transaction do
    association(:bucket)
    description 'A sac of figs'
    effective_date { 1.day.ago }
    association(:source, factory: :bank_account)
    amount 100
  end

  factory :expense_transaction, parent: :transaction, class: 'Transaction::Expense'
  factory :income_transaction, parent: :transaction, class: 'Transaction::Expense'
end
