FactoryGirl.define do
  factory :pay_day do
    association(:budget)
    effective_date { Time.current.to_date }
  end
end
