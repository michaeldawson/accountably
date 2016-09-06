FactoryGirl.define do
  factory :transaction do
    association(:bucket)
    description 'A sac of figs'
    effective_date { 1.day.ago }
    amount(-100)
  end
end
