# This class exposes reporting data to views and other classes. It can report on a budget (all buckets), or a single
# bucket.

class Report
  delegate :percent_through_period, :past?, :present?, to: :cycle

  def spend
    @spend ||= expenses.sum(:amount)
  end

  def spend_as_percent_of_balance
    return 0 if balance.zero?
    return 100 if balance.negative?
    ((spend / balance) * 100).round
  end

  def over_spent?
    spend > balance
  end

  def balance
    raise NotImplementedError.new('Reporting on previous balances not yet supported') unless cycle.current?
    @balance ||= reportable_balance
  end

  private

  # Subclasses must implement these methods
  def expenses
    raise NotImplementedError
  end

  def budgeted
    raise NotImplementedError
  end

  def reportable_balance
    raise NotImplementedError
  end
end
