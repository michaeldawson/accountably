module Bank
  module Adapter
    class NAB
      def initialize(bank_login)
        @bank_login = bank_login
      end

      def reconcile(bank_account, since: nil)
        login unless logged_in

        NABAccountsPage.new.open_account(bank_account)
        NABTransactionsPage.new.reconcile(bank_account: bank_account, since: since)

        bank_account.update!(last_reconciled: Time.current)
      end

      private

      attr_reader :bank_login
      attr_accessor :logged_in

      def login
        login_page = NABLoginPage.new
        login_page.load
        success = login_page.login(bank_login)

        self.logged_in = success
      end
    end
  end
end
