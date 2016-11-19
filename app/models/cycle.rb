# A Cycle is the usual pay / budget cycle for our users (weekly, fortnightly, etc). This class exposes reporting data
# for each budget cycle, to make it available in reports and views.

class Cycle
  attr_accessor :start_date, :length

  delegate :past?, to: :end_date
  delegate :future?, to: :start_date

  def initialize(start_date, length)
    @start_date = start_date.to_date
    @length = length
  end

  def end_date
    (start_date + length_as_date_delta).to_date
  end

  def date_range
    start_date..end_date
  end

  def current?
    date_range.cover?(Time.current)
  end

  def days_remaining
    return false unless current?
    (end_date.to_date - Time.current.to_date).to_i
  end

  def percent_through_period
    return 100 unless current?
    (days_remaining.to_f / days_in_cycle * 100).round
  end

  private

  def length_as_date_delta
    case length
    when 'weekly' then 1.week
    when 'fortnightly' then 1.fortnight
    when 'monthly' then 1.month
    end
  end

  def days_in_cycle
    (end_date.to_date - start_date.to_date).to_i
  end
end
