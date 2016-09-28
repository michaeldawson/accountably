FactoryGirl.define do
  factory :account do
    association(:budget)
    sequence(:name) { |n| "Account #{n}" }
    amount 1
  end
end
