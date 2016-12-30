FactoryGirl.define do
  factory :bucket do
    association(:budget)
    sequence(:name) { |n| "Account #{n}" }
    amount 1
  end
end
