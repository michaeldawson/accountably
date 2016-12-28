module API
  module Int
    class BaseController < ActionController::Base
      def current_budget
        current_user.budget
      end
    end
  end
end
