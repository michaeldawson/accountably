class BudgetController < ApplicationController
  SETUP_STEPS = [1, 2, 3].freeze

  respond_to :js

  before_action :authenticate_user!
  before_action :require_current_budget, except: %i(new create)

  def new
    redirect_to root_path and return if user_has_budget?
  end

  def create
    if budget.save && budget.create_first_pay_day
      redirect_to edit_budget_path
    else
      flash[:error] = "Nope: #{budget.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def update
    if budget.update(budget_params)
      flash[:notice] = 'Budget was updated'
      redirect_to edit_budget_path if next_step_number.present?
    else
      flash[:error] = "Nope: #{budget.errors.full_messages.to_sentence}"
      render :new
    end
  end

  private

  helper_method def step_number
    return params[:step].to_i if SETUP_STEPS.include?(params[:step].to_i)
    next_step_number || SETUP_STEPS.last
  end

  def next_step_number
    return 1 unless user_has_budget?
    return 2 unless current_budget.bank_logins.exists?
    return 3 unless current_budget.buckets.exists?
  end

  def user_has_budget?
    current_user.budget.present?
  end

  helper_method def budget
    @budget ||= current_budget || Budget.new(budget_params)
  end

  helper_method def budget_report
    @budget_report ||= Report::BudgetReport.new(budget)
  end

  helper_method def bank_login
    @bank_login ||= budget.bank_logins.first_or_initialize
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
