class BudgetsController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to new_budget_path and return unless user_has_budget?
    redirect_to budget_path(current_user.budget)
  end

  def new
    redirect_to root_path and return if user_has_budget?
    budget.accounts.build if budget.accounts.empty?
  end

  def create
    if budget.save && budget.pay_days.create(effective_date: budget.first_pay_day)
      flash[:notice] = 'Budget was saved'
      redirect_to budget_path(budget)
    else
      flash[:error] = "Nope: #{budget.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def update
    if budget.update(budget_params)
      flash[:notice] = 'Budget was updated'
      redirect_to budget_path(budget)
    else
      flash[:error] = "Nope: #{budget.errors.full_messages.to_sentence}"
      render :new
    end
  end

  private

  def user_has_budget?
    current_user.budget.present?
  end

  helper_method :budget
  def budget
    @budget ||= Budget.find(params[:id]) if params.key?(:id)
    @budget ||= Budget.new(budget_params)
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
    [:cycle_length, :first_pay_day, accounts_attributes: [:id, :name, :amount, :_destroy]]
  end
end
