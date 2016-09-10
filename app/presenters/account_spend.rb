class AccountSpend
  def initialize(account, cycle)
    @account = account
    @cycle = cycle
  end

  def spent
    account.expenses.where(effective_date: cycle).sum(:amount)
  end

  private

  attr_reader :account, :cycle
end
