module Bank
  class LoginsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_current_budget

    def create
      if bank_login.save
        redirect_to edit_budget_path
      else
        render json: { success: false, errors: bank_login.errors }
      end
    end

    def update
      if bank_login.update(bank_login_params)
        redirect_to edit_budget_path
      else
        render json: { success: false, errors: bank_login.errors }
      end
    end

    private

    def bank_login
      @bank_login ||= Bank::Login.find(params[:id]) if params.key?(:id)
      @bank_login ||= Bank::Login.new(bank_login_params.merge(default_bank_login_params))
    end

    def bank_login_params
      params.require(:bank_login).permit(permitted_bank_login_attributes) if params.key?(:bank_login)
    end

    def permitted_bank_login_attributes
      { credentials: [:user_id, :password] }
    end

    def default_bank_login_params
      { adapter_type: 'NAB', budget: current_budget }
    end
  end
end
