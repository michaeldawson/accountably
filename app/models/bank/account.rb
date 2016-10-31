module Bank
  class Account < ApplicationRecord
    belongs_to :login, class_name: 'Bank::Login', inverse_of: :accounts
    has_one :budget, through: :login, inverse_of: :bank_accounts

    validates :login, presence: true

    def to_s
      "#{name} account"
    end

    def reconcile(since: nil)
      with_headless_driver_if_available do
        login.reconcile(self, since: since)
      end
    end

    def with_headless_driver_if_available
      if Headless::CliUtil.application_exists?('Xvfb')
        Headless.ly { yield }
      else
        yield
      end
    end
  end
end
