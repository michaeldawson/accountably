require_dependency 'bank/adapter/selenium/nab/account/transaction'

module Bank
  module Adapter
    class Selenium
      class NAB < Bank::Adapter::Selenium
        class Account
          ACCOUNT_ROW_SELECTOR = '#accountBalances_nonprimary_subaccounts tr'.freeze
          TRANSACTION_ROW_SELECTOR = '#transactionHistoryTable tbody tr'.freeze
          NEXT_PAGE_WRAPPER_SELECTOR = '#someItems'.freeze

          def initialize(session:, bank_account:)
            @session = session
            @bank_account = bank_account
          end

          # Reconcile transactions on this page. Stop if we've encountered 3 success transactions that were already in
          # the system, or if there are no next pages.
          def reconcile(since: nil)
            go_to_account_page

            loop do
              success = parse_page(accept_transactions_since: since)

              break unless success
              break unless next_page
            end
          end

          private

          attr_reader :session, :bank_account

          def go_to_account_page
            row = session.find(ACCOUNT_ROW_SELECTOR, text: bank_account.name)

            session.within row do
              session.click_link('Transactions')
            end
          end

          def parse_page(accept_transactions_since: nil)
            successive_failures = 0

            transaction_rows.each do |row|
              success = parse_row(row, accept_transactions_since: accept_transactions_since)

              if success
                successive_failures = 0
              else
                successive_failures += 1
              end

              return false if successive_failures == 3
            end

            true
          end

          def transaction_rows
            session.all(TRANSACTION_ROW_SELECTOR)
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
            return false unless session.has_css?(NEXT_PAGE_WRAPPER_SELECTOR)

            session.within NEXT_PAGE_WRAPPER_SELECTOR, match: :first do
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
