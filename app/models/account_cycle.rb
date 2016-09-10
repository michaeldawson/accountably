class AccountCycle
  def initialize(account, cycle)
    @account = account
    @cycle = cycle
  end

  delegate :amount, to: :account

  def spent
    @spent ||= account.expenses.where(effective_date: cycle).sum(:amount)
  end

  def available
    account.balance > 0 ? account.balance : 0
  end

  def on_track_spend
    (account.amount * cycle_completion_factor).round(2)
  end

  def overspent?
    spent > account.amount
  end

  def max
    @max ||= [amount, spent].max
  end

  private

  attr_reader :account, :cycle

  # Return 1 if cycle is over. Otherwise, return the fraction of completion of a current cycle.
  def cycle_completion_factor
    return 1 if cycle.last.past?

    days_into_cycle = Time.current.to_date - cycle.first.to_date
    cycle_length = cycle.last.to_date - cycle.first.to_date

    days_into_cycle.to_f / cycle_length
  end
end
