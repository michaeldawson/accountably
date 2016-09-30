class Reconciliation
  include ActiveModel::Model

  attr_accessor :expense_id, :account_id, :matching_pattern

  def perform
    transfer_transaction
    create_matching_pattern if matching_pattern.present?
  end

  private

  def transfer_transaction
    Transaction.transaction do
      expense.revert
      expense.update!(account: account)
      expense.apply
    end
  end

  def create_matching_pattern
    TransactionPattern.create!(account: account, pattern: matching_pattern)
  end

  def expense
    @expense ||= Transaction::Expense.find(expense_id)
  end

  def account
    @account ||= Account.find(account_id)
  end
end
