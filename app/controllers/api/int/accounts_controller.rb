module API
  module Int
    class AccountsController < BaseController
      def index
        render json: accounts
      end

      def create
        if account.save
          render json: account
        else
          render json: account.errors
        end
      end

      def update
        account.update(account_params)
        head :ok
      end

      private

      def accounts
        return Account.none unless current_budget
        @accounts ||= current_budget.accounts
      end

      def account
        @account ||= current_budget.accounts.find(params[:id]) if params.key?(:id)
        @account ||= current_budget.accounts.new(account_params)
      end

      def account_params
        params.require(:account).permit(:id, :name, :amount) if params.key?(:account)
      end
    end
  end
end
