class Report
  class BudgetReport < Report
    delegate :start_date, :end_date, :percent_through_period, to: :cycle, prefix: true

    def initialize(budget, cycle = nil)
      @budget = budget
      @cycle = cycle || budget.current_cycle
    end

    def expenses_by_bucket
      expenses.group(:account).sum(:amount)
    end

    private

    attr_reader :budget, :cycle

    def expenses
      budget.expenses.where(effective_date: cycle.date_range)
    end

    def budgeted
      @budgeted ||= budget.total
    end

    def reportable_balance
      budget.buckets.sum(:balance)
    end
  end
end
