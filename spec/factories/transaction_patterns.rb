FactoryGirl.define do
  factory :transaction_pattern do
    association(:account)
    pattern 'MyString'
  end
end
