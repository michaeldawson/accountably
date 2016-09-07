FactoryGirl.define do
  factory :budget do
    association :user
    cycle_length 'fortnightly'
    first_pay_day { Time.current.to_date }
    after(:build) do |budget|
      budget.accounts = build_list :account, 1, budget: budget if budget.accounts.empty?
    end
  end
end
