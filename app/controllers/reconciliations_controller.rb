class ReconciliationsController < ApplicationController
  def create
    if reconciliation.perform
      flash[:notice] = 'Transaction was reconciled'
      redirect_to expense.bucket.budget.default_bucket
    else
      flash[:error] = "Sorry, that didn't work: #{reconciliation.errors.full_messages.to_sentence}"
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
    params.require(:reconciliation).permit(*permitted_attributes) if params.key?(:reconciliation)
  end

  def permitted_attributes
    [:expense_id, :bucket_id, :save_matching_pattern, :matching_pattern]
  end
end
