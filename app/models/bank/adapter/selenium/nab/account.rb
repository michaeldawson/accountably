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

          def reconcile(since: nil)
            go_to_account_page

            loop do
              parse_page(accept_transactions_since: since)
              break unless next_page
            end
          end

          def go_to_account_page
            row = session.find('#accountBalances_nonprimary_subaccounts tr', text: bank_account.name)

            session.within row do
              session.click_link('Transactions')
            end
          end

          def parse_page(accept_transactions_since: nil)
            transaction_rows.each { |row| parse_row(row, accept_transactions_since: accept_transactions_since) }
            true
          end

          private

          attr_reader :session, :bank_account

          def transaction_rows
            session.all('#transactionHistoryTable tbody tr')
          end

          def parse_row(row, accept_transactions_since: nil)
            Transaction.new(
              raw_data: row.all('td').map(&:text),
              bank_account: bank_account,
              accept_transactions_since: accept_transactions_since,
              transaction_patterns: transaction_patterns,
            ).parse!
          end

          def transaction_patterns
            @transaction_patterns ||= bank_account.budget.transaction_patterns
          end

          def next_page
            return false unless session.has_css?('#someItems')

            session.within '#someItems', match: :first do
              return false unless session.has_link?('Next')
              session.click_on 'Next'
            end

            true
          end
        end
      end
    end
  end
end
