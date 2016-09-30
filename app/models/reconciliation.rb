class Reconciliation
  include ActiveModel::Model

  attr_accessor :expense_id, :account_id, :account_pattern

  def perform
    Transaction.transaction do
      expense.revert
      expense.update!(account: account)
      expense.apply
    end
  end

  private

  def expense
    @expense ||= Transaction::Expense.find(expense_id)
  end

  def account
    @account ||= Account.find(account_id)
  end
end
