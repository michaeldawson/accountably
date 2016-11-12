module ApplicationHelper
  def page_specific_javascript_data
    {
      controller: controller_name,
      action: action_name
    }
  end

  def formatted_date(date)
    date.strftime('%a, %d %b')
  end
end
