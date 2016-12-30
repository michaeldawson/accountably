class BucketsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_budget

  def update
    if bucket.update(bucket_attributes)
      flash[:notice] = 'Bucket was updated'
      redirect_to bucket
    else
      flash[:error] = "Sorry, that didn't work"
      render 'edit'
    end
  end

  def reconcile
    @bucket = current_budget.default_bucket
    render 'show'
  end

  private

  helper_method def bucket
    @bucket ||= Bucket.find(params[:id])
  end

  helper_method def budget_report
    @budget_report ||= Report::BudgetReport.new(current_budget, current_budget.current_cycle)
  end

  def bucket_attributes
    params.require(:bucket).permit(:name, :amount, :balance)
  end

  helper_method def transaction
    @transaction ||= Transaction::Expense.new(effective_date: Time.current.to_date)
  end
end
