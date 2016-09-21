module Bank
  class Login < ActiveRecord::Base
    belongs_to :budget, inverse_of: :bank_logins
    has_many :accounts, class_name: 'Bank::Account', inverse_of: :login

    attribute :credentials, :encrypted_serialized_json
  end
end
