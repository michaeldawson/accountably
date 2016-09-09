class Budget < ActiveRecord::Base
  CYCLE_LENGTHS = %w(weekly fortnightly monthly).freeze

  belongs_to :user
  has_many :accounts, inverse_of: :budget
  has_many :pay_days, inverse_of: :budget

  validates :user, presence: true
  validates :accounts, length: { minimum: 1 }
  validates :first_pay_day, presence: true
  validates :cycle_length, inclusion: { in: CYCLE_LENGTHS }

  accepts_nested_attributes_for :accounts, allow_destroy: true, reject_if: proc { |attrs| attrs['name'].blank? }

  after_create -> { pay_days.create!(effective_date: first_pay_day) }

  def total
    accounts.sum(:amount).to_f
  end

  def current_cycle
    current_cycle_start..current_cycle_end
  end

  private

  def current_cycle_start
    pay_days.order(:effective_date).last&.effective_date || first_pay_day
  end

  def current_cycle_end
    current_cycle_start + cycle_as_date_delta
  end

  def cycle_as_date_delta
    case cycle_length
    when 'weekly' then 1.week
    when 'fortnightly' then 1.fortnight
    when 'monthly' then 1.month
    end
  end
end
