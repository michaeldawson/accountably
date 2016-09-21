FactoryGirl.define do
  factory :bank_login, class: 'Bank::Login' do
    association(:budget)
    credentials 'MyString'
  end
end
