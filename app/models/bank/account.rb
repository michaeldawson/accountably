module Bank
  class Account < ActiveRecord::Base
    VALID_ADAPTER_TYPES = %w(NAB).freeze
    self.table_name = :bank_accounts

    belongs_to :budget, inverse_of: :bank_accounts

    validates :adapter_type, inclusion: { in: VALID_ADAPTER_TYPES }

    def adapter
      @adapter ||= "Bank::Adapter::Selenium::#{adapter_type}".constantize
    end
  end
end
