class Account < ActiveRecord::Base
  belongs_to :budget, inverse_of: :accounts
  has_many :transactions, inverse_of: :account
  has_many :expenses, -> { where(type: 'Transaction::Expense') }, class_name: 'Transaction'
  has_many :pay_day_transactions, -> { where(type: 'Transaction::Income') }, class_name: 'Transaction'

  validates :budget, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :balance, presence: true

  def spent_this_cycle
    expenses.where(effective_date: budget.current_cycle).sum(:amount)
  end
end
