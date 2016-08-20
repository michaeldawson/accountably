class Budget < ActiveRecord::Base
  CYCLE_LENGTHS = %w(weekly fortnightly monthly)

  belongs_to :user
  has_many :buckets, inverse_of: :budget

  validates :user, presence: true
  validates :buckets, length: { minimum: 1 }
  validates :first_pay_day, presence: true
  validates :cycle_length, inclusion: { in: CYCLE_LENGTHS }

  accepts_nested_attributes_for :buckets, allow_destroy: true, reject_if: Proc.new { |attrs| attrs['name'].blank? }

  def total
    buckets.sum(:amount).to_f
  end

  def apply!
    Bucket.transaction do
      buckets.each(&:apply_budgeted_amount!)
    end
  end
end
