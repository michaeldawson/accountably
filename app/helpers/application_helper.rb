module ApplicationHelper
  def formatted_date(date)
    date.strftime('%a, %d %b')
  end
end
