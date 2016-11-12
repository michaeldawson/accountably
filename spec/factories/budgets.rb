FactoryGirl.define do
  factory :budget_without_accounts, class: Budget, aliases: [:skip_validation] do
    association :user
    target 100.0
    cycle_length 'fortnightly'
    first_pay_day { Time.current.to_date }
  end

  factory :budget, parent: :budget_without_accounts do
    after(:build) do |budget|
      budget.accounts = build_list :account, 1, budget: budget if budget.accounts.empty?
    end
  end
end
