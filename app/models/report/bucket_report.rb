class Report
  class BucketReport < Report
    def initialize(bucket, cycle = nil)
      @bucket = bucket
      @cycle = cycle || bucket.budget.current_cycle
    end

    private

    attr_reader :bucket, :cycle

    def expenses
      bucket.expenses.where(effective_date: cycle.date_range)
    end

    def budgeted
      bucket.amount
    end

    def reportable_balance
      bucket.balance
    end
  end
end
