class Report
  class BudgetReport < Report
    def initialize(budget, cycle = nil)
      @budget = budget
      @cycle = cycle || budget.current_cycle
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
      budget.accounts.sum(:balance)
    end
  end
end
