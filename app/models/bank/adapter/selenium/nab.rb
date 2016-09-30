require_dependency 'bank/adapter/selenium/nab/login'
require_dependency 'bank/adapter/selenium/nab/account'

module Bank
  module Adapter
    class Selenium
      class NAB < Bank::Adapter::Selenium
        def initialize(bank_login)
          @bank_login = bank_login
        end

        def reconcile(bank_account, since: nil)
          login unless logged_in
          Account.new(session, bank_account).reconcile(since: since)
        end

        private

        attr_reader :bank_login
        attr_accessor :logged_in

        def login
          self.logged_in = Login.new(session, bank_login).login
        end
      end
    end
  end
end
