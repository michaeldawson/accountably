require_dependency 'bank/adapter/selenium/nab/account/transaction'

module Bank
  module Adapter
    class Selenium
      class NAB < Bank::Adapter::Selenium
        class Account
          def initialize(session, bank_account)
            @session = session
            @bank_account = bank_account
          end

          def reconcile
            go_to_account_page
            loop do
              parse_page
              break unless next_page
            end
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

          def next_page
            return false unless session.has_css?('#someItems')

            session.within '#someItems', match: :first do
              session.click_on 'Next'
            end

            true
          end
        end
      end
    end
  end
end
