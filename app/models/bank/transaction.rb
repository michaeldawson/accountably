# Parse a bank transaction, with details received from a bank adapter.

module Bank
  class Transaction
    def initialize(transaction_data:, bank_account:, accept_transactions_since: nil)
      @amount = transaction_data.fetch(:amount)
      @effective_date = transaction_data.fetch(:effective_date)
      @description = transaction_data.fetch(:description)

      @bank_account = bank_account
      @accept_transactions_since = accept_transactions_since
    end

    def parse!
      return if amount.zero?
      return false if effective_date_earlier_than_threshold?
      return false if transaction_already_exists?

      transaction_klass.new(transaction_attributes).save
    end

    private

    attr_reader :amount, :effective_date, :description, :bank_account, :accept_transactions_since

    def transaction_klass
      amount.negative? ? ::Transaction::Expense : ::Transaction::Income
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
