class Transaction::Expense < Transaction
  validates :description, presence: true

  scope :unreconciled, -> { joins(:account).where(accounts: { default: true }) }

  def effective_amount
    amount.to_i.abs * -1
  end
end
