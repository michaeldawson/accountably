class Transaction::Expense < Transaction
  validates :description, presence: true

  scope :unreconciled, -> { joins(:bucket).where(buckets: { default: true }) }

  def effective_amount
    amount.to_i.abs * -1
  end
end
