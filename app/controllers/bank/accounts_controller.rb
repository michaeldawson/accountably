module Bank
  class AccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_current_budget

    private

    helper_method def bank_accounts
      Bank::Account.joins(login: :budget).where(budgets: { id: current_budget.id })
    end
  end
end
