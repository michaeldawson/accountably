class Transaction < ActiveRecord::Base
  attribute :amount, :money

  belongs_to :account, inverse_of: :transactions
  belongs_to :source, polymorphic: true

  validates :account, presence: true
  validates :effective_date, presence: true
  validates :amount, presence: true
  validates :source, presence: true

  before_save -> { raise "Can't directly instantiate a transaction" if self.class == Transaction }

  before_create :apply
  def apply
    account.balance += effective_amount
    account.save!
  end

  def revert
    account.balance -= effective_amount
    account.save!
  end

  def effective_amount
    raise NotImplementedError
  end
end
