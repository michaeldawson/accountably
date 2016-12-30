class PayDay < ApplicationRecord
  belongs_to :budget, inverse_of: :pay_days
  has_many :transactions, as: :source, class_name: 'Transaction::Income'

  validates :budget, presence: true
  validates :effective_date, presence: true, uniqueness: { scope: :budget }

  after_create :apply!
  def apply!
    Transaction.transaction do
      budget.buckets.each do |bucket|
        payday_transaction(bucket).save!
      end
    end
  end

  private

  def payday_transaction(bucket)
    transactions.build(
      bucket: bucket,
      amount: bucket.amount,
      effective_date: effective_date,
      source: self
    )
  end
end
