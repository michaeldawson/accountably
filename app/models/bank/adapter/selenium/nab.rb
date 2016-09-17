module Bank
  module Adapter
    class Selenium
      class NAB < Bank::Adapter::Selenium
        LOGIN_PATH = 'https://ib.nab.com.au/nabib/index.jsp'

        def initialize(user_id, password)
          @user_id ||= user_id
          @password ||= password
        end

        def login
          session.visit LOGIN_PATH
          Page::Login.new(session).login(user_id, password)
        end

        private

        attr_reader :user_id, :password
      end
    end
  end
end
