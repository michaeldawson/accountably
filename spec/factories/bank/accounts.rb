FactoryGirl.define do
  factory :bank_account, class: Bank::Account do
    association(:login, factory: :bank_login)
    name 'MyString'
    sync_from { Time.current }
    adapter_type 'NAB'
  end
end
