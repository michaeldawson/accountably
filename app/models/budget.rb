class Budget < ActiveRecord::Base
  CYCLE_LENGTHS = %w(weekly fortnightly monthly).freeze

  belongs_to :user
  has_many :accounts, inverse_of: :budget

  validates :user, presence: true
  validates :accounts, length: { minimum: 1 }
  validates :first_pay_day, presence: true
  validates :cycle_length, inclusion: { in: CYCLE_LENGTHS }

  accepts_nested_attributes_for :accounts, allow_destroy: true, reject_if: proc { |attrs| attrs['name'].blank? }

  after_create -> { PayDay.create!(budget: self, effective_date: first_pay_day) }

  def total
    accounts.sum(:amount).to_f
  end
end
