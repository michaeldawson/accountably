FactoryGirl.define do
  factory :bank_account, class: Bank::Account do
    association(:budget)
    name 'MyString'
    sync_from { Time.current }
    adapter_type 'NAB'
  end
end
