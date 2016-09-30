class PayDay < ApplicationRecord
  belongs_to :budget, inverse_of: :pay_days
  has_many :transactions, as: :source, class_name: 'Transaction::Income'

  validates :budget, presence: true
  validates :effective_date, presence: true

  after_create :apply!
  def apply!
    Transaction.transaction do
      budget.accounts.each do |account|
        payday_transaction(account).save!
      end
    end
  end

  private

  def payday_transaction(account)
    transactions.build(
      account: account,
      amount: account.amount,
      effective_date: effective_date,
      source: self
    )
  end
end
