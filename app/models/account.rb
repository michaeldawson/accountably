class Account < ApplicationRecord
  attribute :amount, :money
  attribute :balance, :money

  belongs_to :budget, inverse_of: :accounts
  has_many :transactions, inverse_of: :account
  has_many :expenses, -> { where(type: 'Transaction::Expense') }, class_name: 'Transaction::Expense'
  has_many :pay_day_transactions, -> { where(type: 'Transaction::Income') }, class_name: 'Transaction'

  validates :budget, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :balance, presence: true

  def current_cycle
    @current_cycle ||= AccountCycle.new(self, budget.current_cycle)
  end
end
