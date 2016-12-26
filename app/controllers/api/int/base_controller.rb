module Api
  module Int
    class BaseController < JSONAPI::ResourceController
      abstract

      def context
        {
          current_user: current_user
        }
      end
    end
  end
end
