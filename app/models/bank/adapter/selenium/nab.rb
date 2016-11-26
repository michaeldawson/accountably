require_dependency 'bank/adapter/selenium'
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
          account = Account.new(session: session, bank_account: bank_account)
          account.reconcile(since: since)
          cleanup

          bank_account.update!(last_reconciled: Time.current)
        end

        private

        attr_reader :bank_login
        attr_accessor :logged_in

        def login
          success = Login.new(session: session, bank_login: bank_login).login
          self.logged_in = success
        end
      end
    end
  end
end
