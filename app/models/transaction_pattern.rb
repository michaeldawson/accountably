class TransactionPattern < ApplicationRecord
  belongs_to :account, inverse_of: :transaction_patterns

  validates :account, presence: true
  validates :pattern, presence: true

  after_create :reconcile_all_for_budget
  def reconcile_all_for_budget
    budget.default_account.transactions.each do |transaction|
      next unless applies_to?(transaction)
      Reconciliation.new(expense_id: transaction.id, account_id: account.id).perform
    end
  end

  def applies_to?(transaction)
    pattern_regexp.match(transaction.description)
  end

  private

  def pattern_regexp
    Regexp.new(pattern)
  end

  def budget
    @budget ||= account.budget
  end
end
