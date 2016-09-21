module Bank
  module Adapter
    class Selenium
      class NAB < Bank::Adapter::Selenium
        class Account
          def initialize(session, bank_account)
            @session = session
            @bank_account = bank_account
          end

          def fetch_recent_transactions
            go_to_account_page
            parse_page
          end

          def go_to_account_page
            row = session.find('#accountBalances_nonprimary_subaccounts tr', text: bank_account.name)

            session.within row do
              session.click_link('Transactions')
            end
          end

          def parse_page
            transaction_rows.each { |row| parse_row(row) }
            true
          end

          private

          attr_reader :session, :bank_account

          def transaction_rows
            session.all('#transactionHistoryTable tbody tr')
          end

          def parse_row(row)
            Transaction.new(row.all('td').map(&:text), bank_account).parse!
          end
        end
      end
    end
  end
end
