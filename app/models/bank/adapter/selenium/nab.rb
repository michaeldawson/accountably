module Bank
  module Adapter
    class Selenium
      class NAB < Bank::Adapter::Selenium
        def initialize(user_id, password)
          @user_id = user_id
          @password = password
        end

        def login
          Page::Login.new(session).login(user_id, password)
        end

        def fetch_recent_transactions(account_name)
          Page::Accounts.new(session).fetch_recent_transactions(account_name)
        end

        private

        attr_reader :user_id, :password
      end
    end
  end
end
