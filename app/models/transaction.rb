class Transaction < ApplicationRecord
  attribute :amount, MoneyType.new

  belongs_to :bucket, inverse_of: :transactions
  belongs_to :source, polymorphic: true

  validates :bucket, presence: true
  validates :effective_date, presence: true
  validates :amount, presence: true
  validates :source, presence: true

  before_save -> { raise "Can't directly instantiate a transaction" if self.class == Transaction }

  before_create :apply
  def apply
    bucket.balance += effective_amount
    bucket.save!
  end

  before_destroy :revert
  def revert
    bucket.balance -= effective_amount
    bucket.save!
  end

  def effective_amount
    raise NotImplementedError
  end
end
