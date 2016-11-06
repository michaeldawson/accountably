class Report
  class AccountReport < Report
    def initialize(account, cycle = nil)
      @account = account
      @cycle = cycle || account.budget.current_cycle
    end

    private

    attr_reader :account, :cycle

    def expenses
      account.expenses.where(effective_date: cycle.date_range)
    end

    def budgeted
      account.amount
    end

    def reportable_balance
      account.balance
    end
  end
end
