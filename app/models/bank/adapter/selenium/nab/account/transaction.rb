module Bank
  module Adapter
    class Selenium
      class NAB
        class Account
          class Transaction
            def initialize(raw_data, bank_account)
              @raw_data = raw_data
              @bank_account = bank_account
            end

            def parse!
              return false if amount.zero?
              transaction_klass.find_or_create_by!(transaction_attributes)
            end

            private

            attr_reader :bank_account, :raw_data

            def transaction_klass
              debit_amount.zero? ? ::Transaction::Expense : ::Transaction::Income
            end

            def transaction_attributes
              {
                source: bank_account,
                effective_date: effective_date,
                description: description,
                amount: amount.abs,
                account: account
              }
            end

            def effective_date
              DateTime.strptime(raw_data[0], '%d %b %y')
            end

            def description
              raw_data[1]
            end

            def debit_amount
              raw_data[2].to_f
            end

            def credit_amount
              raw_data[3].to_f
            end

            def amount
              [debit_amount, credit_amount].reject(&:zero?).first.to_i
            end

            def account
              bank_account.login.budget.default_account
            end
          end
        end
      end
    end
  end
end
