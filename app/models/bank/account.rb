module Bank
  class Account < ActiveRecord::Base
    VALID_ADAPTER_TYPES = %w(NAB).freeze
    belongs_to :login, class_name: 'Bank::Login', inverse_of: :accounts

    validates :adapter_type, inclusion: { in: VALID_ADAPTER_TYPES }

    def adapter
      @adapter ||= "Bank::Adapter::Selenium::#{adapter_type}".constantize
    end
  end
end
