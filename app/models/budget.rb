class Budget < ApplicationRecord
  CYCLE_LENGTHS = %w(weekly fortnightly monthly).freeze

  attribute :target, MoneyType.new

  belongs_to :user
  has_many :buckets, inverse_of: :budget
  has_many :expenses, through: :buckets
  has_many :transaction_patterns, through: :buckets
  has_many :bank_logins, inverse_of: :budget, class_name: 'Bank::Login'
  has_many :bank_accounts, through: :bank_logins, inverse_of: :budget, source: :accounts, class_name: 'Bank::Account'
  has_many :pay_days, inverse_of: :budget

  validates :user, presence: true
  validates :target, presence: true
  validates :first_pay_day, presence: true
  validates :cycle_length, inclusion: { in: CYCLE_LENGTHS }

  def total
    Money.new(accounts.sum(:amount).to_f)
  end

  def reconcile_bank_accounts_for_current_cycle
    bank_accounts.each do |bank_account|
      bank_account.reconcile(since: current_cycle.start_date)
    end
  end

  def current_cycle
    @current_cycle ||= Cycle.new(current_cycle_start, cycle_length).tap do |cycle|
      while cycle.past?
        next_pay_day = pay_days.create(effective_date: cycle.end_date)
        cycle.start_date = next_pay_day.effective_date
      end
    end
  end

  def create_first_pay_day
    pay_days.create(effective_date: first_pay_day)
  end

  # Transactions go into this bucket before they're categorised.
  def default_bucket
    @default_bucket ||= buckets.uncategorised.first || buckets.uncategorised.create!(name: 'Uncategorised')
  end

  private

  def current_cycle_start
    (last_pay_day || create_first_pay_day).effective_date
  end

  def last_pay_day
    pay_days.order(:effective_date).last
  end
end
