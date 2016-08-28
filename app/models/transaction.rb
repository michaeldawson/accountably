class Transaction < ActiveRecord::Base
  belongs_to :bucket, inverse_of: :transactions

  validates :bucket, presence: true
  validates :occurred_at, presence: true
  validates :description, presence: true
  validates :amount, presence: true

  before_create :apply
  def apply
    bucket.balance += amount
    bucket.save
  end
end
