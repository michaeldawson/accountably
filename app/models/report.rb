# This class exposes reporting data to views and other classes. It can report on a budget (all accounts), or a single
# account.

class Report
  delegate :percent_through_period, to: :cycle

  def spend
    @spend ||= expenses.sum(:amount)
  end

  def on_track_spend
    @on_track_spend ||= (budgeted * percent_through_period / 100).round
  end

  def spend_as_percent_of_on_track_spend
    return 0 if on_track_spend.zero?
    ((spend / on_track_spend) * 100).round
  end

  def spend_as_percent_of_budget
    return 0 if budgeted.zero?
    ((spend / budgeted) * 100).round
  end

  def ahead_of_on_track_spend?
    spend > on_track_spend
  end

  def over_spent?
    spend > budgeted
  end

  def balance
    raise NotImplementedError.new('Reporting on previous balances not yet supported') unless cycle.current?
    reportable_balance
  end
end
