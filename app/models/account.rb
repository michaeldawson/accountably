class Account < ActiveRecord::Base
  belongs_to :budget, inverse_of: :accounts
  has_many :transactions, inverse_of: :account

  validates :budget, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :balance, presence: true

  def spent_this_cycle
    transactions.where(effective_date: budget.current_cycle).sum(:amount)
  end
end
