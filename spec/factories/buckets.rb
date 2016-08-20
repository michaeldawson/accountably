FactoryGirl.define do
  factory :bucket do
    association(:budget)
    name "MyString"
    amount 1
  end
end
