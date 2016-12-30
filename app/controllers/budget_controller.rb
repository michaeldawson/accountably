class BudgetController < ApplicationController
  respond_to :js

  before_action :authenticate_user!
  before_action :require_current_budget, except: %i(new create)

  def new
    redirect_to root_path and return if user_has_budget?
  end

  def create
    if budget.save && budget.create_first_pay_day
      flash[:notice] = 'Budget was saved'
      redirect_to budget_path
    else
      flash[:error] = "Nope: #{budget.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def update
    if budget.update(budget_params)
      flash[:notice] = 'Budget was updated'
      redirect_to budget_path
    else
      flash[:error] = "Nope: #{budget.errors.full_messages.to_sentence}"
      render :new
    end
  end

  private

  def user_has_budget?
    current_user.budget.present?
  end

  helper_method def budget
    @budget ||= current_budget || Budget.new(budget_params)
  end

  helper_method def budget_report
    @budget_report ||= Report::BudgetReport.new(budget)
  end

  def budget_params
    return nil unless params.key?(:budget)
    provided_budget_params = params.require(:budget).permit(*permitted_budget_attributes).to_h
    default_budget_params.merge(provided_budget_params)
  end

  def default_budget_params
    { user: current_user }
  end

  def permitted_budget_attributes
    %i(cycle_length first_pay_day target)
  end
end
