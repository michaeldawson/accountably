FactoryGirl.define do
  factory :budget do
    association :user
    cycle_length 'fortnightly'
    after(:build) do |budget|
      budget.buckets = build_list :bucket, 1, budget: budget if budget.buckets.empty?
    end
  end
end
