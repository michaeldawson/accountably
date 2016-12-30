class TransactionPattern < ApplicationRecord
  belongs_to :bucket, inverse_of: :transaction_patterns

  validates :bucket, presence: true
  validates :pattern, presence: true

  after_create :reconcile_all_for_budget
  def reconcile_all_for_budget
    budget.default_bucket.transactions.each do |transaction|
      next unless matches?(transaction.description)
      Reconciliation.new(expense_id: transaction.id, bucket_id: bucket.id).perform
    end
  end

  def matches?(transaction_description)
    pattern_regexp.match(transaction_description)
  end

  private

  def pattern_regexp
    Regexp.new(pattern, Regexp::IGNORECASE)
  end

  def budget
    @budget ||= bucket.budget
  end
end
