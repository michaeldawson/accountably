FactoryGirl.define do
  factory :transaction_pattern do
    association(:bucket)
    pattern 'MyString'
  end
end
