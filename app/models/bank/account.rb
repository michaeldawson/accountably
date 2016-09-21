module Bank
  class Account < ActiveRecord::Base
    belongs_to :login, class_name: 'Bank::Login', inverse_of: :accounts

    validates :login, presence: true

    def reconcile
      login.reconcile(self)
    end
  end
end
