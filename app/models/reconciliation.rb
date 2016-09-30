class Reconciliation
  include ActiveModel::Model

  attr_accessor :expense_id, :account_id, :save_matching_pattern, :matching_pattern

  validates :expense_id, presence: true
  validates :account_id, presence: true

  def perform
    return false unless valid?
    transfer_transaction
    create_matching_pattern if save_matching_pattern
    true
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
