class Account < ApplicationRecord
  attribute :amount, MoneyType.new
  attribute :balance, MoneyType.new

  belongs_to :budget, inverse_of: :accounts
  has_many :transactions, inverse_of: :account
  has_many :expenses, -> { where(type: 'Transaction::Expense') }, class_name: 'Transaction::Expense'
  has_many :pay_day_transactions, -> { where(type: 'Transaction::Income') }, class_name: 'Transaction'
  has_many :transaction_patterns, inverse_of: :account

  validates :budget, presence: true
  validates :amount, presence: true
  validates :balance, presence: true
  validate :amount_not_negative # Can't use a numericality validation as it's sometimes cast as '$x.xx'
  def amount_not_negative
    errors.add(:amount, "can't be negative") if amount.negative?
  end

  scope :uncategorised, -> { where(default: true) }
  scope :categorised, -> { where(default: false) }
end
