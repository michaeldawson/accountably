class BudgetsController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to new_budget_path and return unless user_has_budget?
  end

  private

  def user_has_budget?
    current_user.budgets.exists?
  end

  helper_method :budget
  def budget
    @budget ||= Budget.new(budget_params)
  end

  def budget_params
    return nil unless params.key?(:budget)
    params.require(:budget).permit(buckets_attributes: [:name, :amount])
  end
end
