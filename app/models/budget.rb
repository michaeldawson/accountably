class Budget < ApplicationRecord
  CYCLE_LENGTHS = %w(weekly fortnightly monthly).freeze

  belongs_to :user
  has_many :accounts, inverse_of: :budget
  has_many :transaction_patterns, through: :accounts
  has_many :bank_logins, inverse_of: :budget, class_name: 'Bank::Login'
  has_many :bank_accounts, through: :bank_logins, inverse_of: :budget, source: :accounts, class_name: 'Bank::Account'
  has_many :pay_days, inverse_of: :budget
  has_many :expenses, through: :accounts

  validates :user, presence: true
  validates :accounts, length: { minimum: 1 }
  validates :first_pay_day, presence: true
  validates :cycle_length, inclusion: { in: CYCLE_LENGTHS }

  accepts_nested_attributes_for :accounts, allow_destroy: true, reject_if: proc { |attrs| attrs['name'].blank? }

  def total
    accounts.sum(:amount).to_f
  end

  def reconcile_bank_accounts_for_current_cycle
    bank_accounts.each do |bank_account|
      bank_account.reconcile(since: current_cycle.start_date)
    end
  end

  def current_cycle
    @current_cycle ||= Cycle.new(current_cycle_start, cycle_length)
  end

  def default_account
    @default_account ||= accounts.find_by(default: true) || accounts.create!(default_account_attributes)
  end

  def create_next_pay_day
    return pay_days.create(effective_date: first_pay_day) unless last_pay_day.present?
    return if current_cycle.current?
    pay_days.create(effective_date: current_cycle.end_date)
  end

  private

  def current_cycle_start
    @current_cycle_start ||= last_pay_day&.effective_date || first_pay_day
  end

  def last_pay_day
    @last_pay_day ||= pay_days.order(:effective_date).last
  end

  def default_account_attributes
    { default: true, name: 'Uncategorised', amount: 0, balance: 0 }
  end
end
