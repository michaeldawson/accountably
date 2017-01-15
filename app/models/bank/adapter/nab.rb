require_dependency 'bank/adapter/selenium'

module Bank
  module Adapter
    class Selenium
      class NAB
        def initialize(bank_login)
          @bank_login = bank_login
        end

        def reconcile(bank_account, since: nil)
          login unless logged_in

          NAB::AccountsPage.new.open_account(bank_account)
          NAB::AccountPage.new.reconcile(since: since)

          bank_account.update!(last_reconciled: Time.current)
        end

        private

        attr_reader :bank_login
        attr_accessor :logged_in

        def login
          success = NAB::LoginPage.new.login(bank_login)
          self.logged_in = success
        end
      end
    end
  end
end
