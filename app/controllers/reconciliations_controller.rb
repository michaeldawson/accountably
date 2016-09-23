class ReconciliationsController < ApplicationController
  private

  helper_method :unreconciled_transactions
  def unreconciled_transactions
    @unreconciled_transactions ||= Transaction::Expense.unreconciled.order(effective_date: :desc)
  end

  helper_method :reconciliation
  def reconciliation
    @reconciliation ||= Reconciliation.new(reconciliation_params)
  end

  helper_method :expense
  def expense
    Transaction::Expense.find(params[:expense_id])
  end

  def reconciliation_params
    params.require(:reconciliation).permit(*permitted_reconciliation_params) if params.key?(:reconciliation_params)
  end

  def permitted_reconciliation_params
    [:expense_id, :account_id, :account_pattern]
  end
end
