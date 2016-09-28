class ReconciliationsController < ApplicationController
  def create
    if reconciliation.perform
      flash[:notice] = 'Transaction was reconciled'
      redirect_to expense.account.budget.default_account
    else
      redirect_to expense
    end
  end

  private

  helper_method :reconciliation
  def reconciliation
    @reconciliation ||= Reconciliation.new(reconciliation_params)
  end

  helper_method :expense
  def expense
    Transaction::Expense.find(params[:expense_id] || reconciliation_params[:expense_id])
  end

  def reconciliation_params
    params.require(:reconciliation).permit(*permitted_reconciliation_params) if params.key?(:reconciliation)
  end

  def permitted_reconciliation_params
    [:expense_id, :account_id, :account_pattern]
  end
end
