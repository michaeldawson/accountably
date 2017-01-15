# Parse a bank a transaction from a bank adapter.

module Bank
  class Transaction
    def initialize(data:, bank_account:, accept_transactions_since: nil, transaction_patterns: [])
      @data = data
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

    attr_reader :data, :bank_account, :accept_transactions_since, :transaction_patterns

    def transaction_klass
      debit_amount.zero? ? ::Transaction::Income : ::Transaction::Expense
    end

    def transaction_attributes
      {
        source: bank_account,
        effective_date: effective_date,
        description: description,
        amount: amount.abs,
        bucket: best_bucket
      }
    end

    def transaction_already_exists?
      transaction_klass.where(
        **transaction_attributes.except(:effective_date, :account),
        effective_date: effective_date_plus_or_minus_one_day,
      ).exists?
    end

    def transaction_patterns
      @transaction_patterns ||= bank_account.budget.transaction_patterns
    end

    def effective_date_plus_or_minus_one_day
      (effective_date - 1.day)..(effective_date + 1.day)
    end

    def best_bucket
      @best_bucket ||= transaction_pattern_match_bucket || default_bucket
    end

    def effective_date_earlier_than_threshold?
      accept_transactions_since && effective_date < accept_transactions_since
    end

    def transaction_pattern_match_bucket
      transaction_patterns.detect { |pattern| pattern.matches?(description) }&.bucket
    end

    def default_bucket
      bank_account.login.budget.default_bucket
    end
  end
end
