module Bank
  module Adapter
    class Selenium
      class NAB
        class Login
          LOGIN_PATH = 'https://ib.nab.com.au/nabib/index.jsp'.freeze

          def initialize(session)
            @session = session
          end

          def login(user_id, password)
            session.visit LOGIN_PATH unless session.current_path == LOGIN_PATH

            session.within '#loginForm' do
              session.find('input[name="userid"]').set(user_id)
              session.find('input[name="password"]').set(password)
              session.click_on 'Login'
            end
          end

          private

          attr_reader :session
        end
      end
    end
  end
end
