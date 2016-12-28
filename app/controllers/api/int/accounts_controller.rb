module API
  module Int
    class AccountsController < BaseController
      def index
        render json: accounts
      end

      private

      def accounts
        return Account.none unless current_budget
        @accounts ||= current_budget.accounts
      end
    end
  end
end
