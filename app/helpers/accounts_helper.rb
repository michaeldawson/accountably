module AccountsHelper
  def account_graph_classes(account_cycle)
    [
      ('overspent' if account_cycle.overspent?),
    ].compact
  end

  def account_graph_width(account_cycle, property)
    width = account_cycle.send(property) / account_cycle.max * 100
    "#{width}%"
  end
end
