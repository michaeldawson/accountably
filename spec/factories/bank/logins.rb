FactoryGirl.define do
  factory :bank_login, class: 'Bank::Login' do
    association(:budget)
    credentials(user_id: 'foo', password: 'bar')
    adapter_type 'NAB'
  end
end
