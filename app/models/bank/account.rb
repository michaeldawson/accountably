module Bank
  class Account < ActiveRecord::Base
    VALID_ADAPTER_TYPES = %w(NAB).freeze
    belongs_to :login, class_name: 'Bank::Login', inverse_of: :accounts

    validates :login, presence: true
    validates :adapter_type, inclusion: { in: VALID_ADAPTER_TYPES }

    def fetch_recent_transactions
      adapter.fetch_recent_transactions(self)
    end

    private

    def adapter
      @adapter ||= adapter_class.new(login)
    end

    def adapter_class
      "Bank::Adapter::Selenium::#{adapter_type}".constantize
    end
  end
end
