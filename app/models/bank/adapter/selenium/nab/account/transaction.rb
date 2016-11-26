module Bank
  module Adapter
    class Selenium
      class NAB
        class Account
          class Transaction
            def initialize(raw_data:, bank_account:, accept_transactions_since: nil, transaction_patterns: [])
              @raw_data = raw_data
              @bank_account = bank_account
              @accept_transactions_since = accept_transactions_since
              @transaction_patterns = transaction_patterns
            end

            def parse!
              return if amount.zero?
              return false if effective_date_earlier_than_threshold?
              return false if transaction_already_exists?

              transaction = transaction_klass.new(transaction_attributes)
              transaction.save
            end

            private

            attr_reader :raw_data, :bank_account, :accept_transactions_since, :transaction_patterns

            def transaction_klass
              debit_amount.zero? ? ::Transaction::Income : ::Transaction::Expense
            end

            def transaction_attributes
              {
                source: bank_account,
                effective_date: effective_date,
                description: description,
                amount: amount.abs,
                account: best_account
              }
            end

            def transaction_already_exists?
              transaction_klass.where(
                **transaction_attributes.except(:effective_date, :account),
                effective_date: effective_date_plus_or_minus_one_day,
              ).exists?
            end

            def effective_date_plus_or_minus_one_day
              (effective_date - 1.day)..(effective_date + 1.day)
            end

            def effective_date
              DateTime.strptime(raw_data[0], '%d %b %y')
            end

            def description
              raw_data[1]
            end

            def debit_amount
              Money.new(raw_data[2].presence || 0)
            end

            def credit_amount
              Money.new(raw_data[3].presence || 0)
            end

            def amount
              [debit_amount, credit_amount].reject(&:zero?).first.to_i
            end

            def best_account
              @best_account ||= transaction_pattern_match_account || default_account
            end

            def effective_date_earlier_than_threshold?
              accept_transactions_since && effective_date < accept_transactions_since
            end

            def transaction_pattern_match_account
              transaction_patterns.detect { |pattern| pattern.matches?(description) }&.account
            end

            def default_account
              bank_account.login.budget.default_account
            end
          end
        end
      end
    end
  end
end
