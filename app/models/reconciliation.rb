class Reconciliation
  include ActiveModel::Model

  attr_accessor :expense_id, :bucket_id, :save_matching_pattern, :matching_pattern

  validates :expense_id, presence: true
  validates :bucket_id, presence: true

  def initialize(*args)
    super(*args)
    self.save_matching_pattern = save_matching_pattern.to_s.to_bool
  end

  def perform
    return false unless valid?
    transfer_transaction
    create_matching_pattern if save_matching_pattern
    true
  end

  private

  def transfer_transaction
    Transaction.transaction do
      expense.revert
      expense.update!(bucket: bucket)
      expense.apply
    end
  end

  def create_matching_pattern
    TransactionPattern.create!(bucket: bucket, pattern: matching_pattern)
  end

  def expense
    @expense ||= Transaction::Expense.find(expense_id)
  end

  def bucket
    @bucket ||= Bucket.find(bucket_id)
  end
end
