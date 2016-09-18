module Bank
  module Adapter
    class Selenium
      class NAB
        class Account
          class Transaction
            def initialize(bank_account, raw_data)
              @bank_account = bank_account
              @raw_data = raw_data
            end

            def parse!
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
                amount: [debit_amount, credit_amount].reject(&:zero?).first.abs,
                account: bank_account.budget.default_account
              }
            end

            def effective_date
              Time.zone.parse(raw_data[0])
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
          end
        end
      end
    end
  end
end
