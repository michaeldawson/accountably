module API
  module Int
    class AccountsController < BaseController
      def index
        render json: accounts
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
        @account ||= current_budget.accounts.find(params[:id])
      end

      def account_params
        params.require(:account).permit(:name, :amount)
      end
    end
  end
end
