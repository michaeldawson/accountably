FactoryGirl.define do
  factory :budget, class: Budget, aliases: [:skip_validation] do
    association :user
    target 100.0
    cycle_length 'fortnightly'
    first_pay_day { Time.current.to_date }
  end
end
