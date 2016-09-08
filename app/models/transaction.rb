class Transaction < ActiveRecord::Base
  belongs_to :account, inverse_of: :transactions
  belongs_to :source, inverse_of: :transactions, polymorphic: true

  validates :account, presence: true
  validates :effective_date, presence: true
  validates :description, presence: true
  validates :amount, presence: true

  before_create :apply
  def apply
    account.balance += amount
    account.save
  end
end
