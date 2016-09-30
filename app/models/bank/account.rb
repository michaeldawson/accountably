module Bank
  class Account < ApplicationRecord
    belongs_to :login, class_name: 'Bank::Login', inverse_of: :accounts
    has_one :budget, through: :login, inverse_of: :bank_accounts

    validates :login, presence: true

    def reconcile(since: nil)
      login.reconcile(self, since: since)
    end
  end
end
