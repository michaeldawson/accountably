class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_current_budget

  def update
    if account.update(account_attributes)
      flash[:notice] = 'Account was updated'
      redirect_to account
    else
      flash[:error] = "Sorry, that didn't work"
      render 'edit'
    end
  end

  def reconcile
    @account = current_budget.default_account
    render 'show'
  end

  private

  helper_method def accounts
    @accounts ||= current_budget.accounts
  end

  helper_method def account
    @account ||= Account.find(params[:id])
  end

  helper_method def budget_report
    @budget_report ||= Report::BudgetReport.new(current_budget, current_budget.current_cycle)
  end

  def account_attributes
    params.require(:account).permit(:name, :amount, :balance)
  end

  helper_method def transaction
    @transaction ||= Transaction::Expense.new(effective_date: Time.current.to_date)
  end
end
