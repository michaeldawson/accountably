class Budget < ActiveRecord::Base
  CYCLE_LENGTHS = %w(weekly fortnightly monthly).freeze

  belongs_to :user
  has_many :accounts, inverse_of: :budget
  has_many :bank_logins, inverse_of: :budget, class_name: 'Bank::Login'
  has_many :bank_accounts, through: :bank_logins, source: :accounts, class_name: 'Bank::Account'
  has_many :pay_days, inverse_of: :budget
  has_many :expenses, through: :accounts

  validates :user, presence: true
  validates :accounts, length: { minimum: 1 }
  validates :first_pay_day, presence: true
  validates :cycle_length, inclusion: { in: CYCLE_LENGTHS }

  accepts_nested_attributes_for :accounts, allow_destroy: true, reject_if: proc { |attrs| attrs['name'].blank? }

  def total
    Money.new(accounts.sum(:amount).to_f)
  end

  def reconcile_bank_accounts_for_current_cycle
    bank_accounts.each do |bank_account|
      bank_account.reconcile(since: current_cycle_start)
    end
  end

  def current_cycle
    current_cycle_start..current_cycle_end
  end

  def current_cycle_days_remaining
    (current_cycle_end - Time.current.to_date).to_i
  end

  def default_account
    @default_account ||= accounts.find_by(default: true) || accounts.create!(default_account_attributes)
  end

  private

  def current_cycle_start
    @current_cycle_start ||= pay_days.order(:effective_date).last&.effective_date || first_pay_day
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

  def default_account_attributes
    { default: true, name: 'Uncategorised', amount: 0, balance: 0 }
  end
end
