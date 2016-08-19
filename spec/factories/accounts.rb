FactoryGirl.define do
  factory :account do
    sequence(:name) { |n| "Account#{n}" }
    association :user
  end
end
