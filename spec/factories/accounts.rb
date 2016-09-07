FactoryGirl.define do
  factory :account do
    association(:budget)
    name 'MyString'
    amount 1
  end
end
