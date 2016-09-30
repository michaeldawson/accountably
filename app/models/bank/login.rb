module Bank
  class Login < ApplicationRecord
    VALID_ADAPTER_TYPES = %w(NAB).freeze

    belongs_to :budget, inverse_of: :bank_logins
    has_many :accounts, class_name: 'Bank::Account', inverse_of: :login

    attribute :credentials, :encrypted_serialized_json

    validates :adapter_type, inclusion: { in: VALID_ADAPTER_TYPES }

    delegate :reconcile, to: :adapter

    private

    def adapter
      @adapter ||= adapter_class.new(self)
    end

    def adapter_class
      "Bank::Adapter::Selenium::#{adapter_type}".constantize
    end
  end
end
