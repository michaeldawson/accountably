class BudgetsController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to new_budget_path and return unless user_has_budget?
  end

  def new
    budget.buckets.build if budget.buckets.empty?
  end

  def create
    if budget.save
      flash[:notice] = 'Budget was saved'
      redirect_to budgets_path
    else
      flash[:error] = "Nope: #{budget.errors.full_messages.to_sentence}"
      render :new
    end
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
    default_budget_params.merge(params.require(:budget).permit(*permitted_budget_attributes))
  end

  def default_budget_params
    { user: current_user }
  end

  def permitted_budget_attributes
    [:cycle_length, buckets_attributes: [:name, :amount]]
  end
end
