class Transaction::ExpensesController < TransactionsController
  private

  helper_method :transaction
  def transaction
    @transaction ||= Transaction::Expense.find(params[:id]) if params.key?(:id)
    @transaction ||= Transaction::Expense.new(transaction_params)
  end

  helper_method :reconciliation
  def reconciliation
    @reconciliation ||= Reconciliation.new
  end
end
