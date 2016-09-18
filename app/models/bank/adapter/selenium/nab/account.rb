module Bank
  module Adapter
    class Selenium
      class NAB
        class Account
          def initialize(session)
            @session = session
          end

          def fetch_recent_transactions(account_name)
            go_to_account_page(account_name)
            parse_page
          end

          def go_to_account_page(account_name)
            row = session.find('#accountBalances_nonprimary_subaccounts tr', text: account_name)

            session.within row do
              session.click_link('Transactions')
            end
          end

          def parse_page
            transaction_rows.each { |row| parse_row(row) }
          end

          private

          attr_reader :session

          def transaction_rows
            session.all('#transactionHistoryTable tbody tr')
          end

          def parse_row(row)
            Transaction.new(row.all('td').map(&:text)).parse!
          end
        end
      end
    end
  end
end
