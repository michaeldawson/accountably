class Reconciliation
  include ActiveModel::Model

  attr_accessor :expense_id, :account_id, :account_pattern

  def initialize(*args)
    super(*args)
  end

  def perform
    expense.update(account_id: account_id)
  end

  private

  def expense
    @expense ||= Transaction::Expense.find(expense_id)
  end
end
