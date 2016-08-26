class Bucket < ActiveRecord::Base
  belongs_to :budget, inverse_of: :buckets

  validates :budget, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :balance, presence: true
end
