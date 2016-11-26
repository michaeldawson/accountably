require_dependency 'bank/adapter/selenium/nab'

module Bank
  module Adapter
    class Selenium
      class NAB < Bank::Adapter::Selenium
        class Login
          LOGIN_PATH = 'https://ib.nab.com.au/nabib/index.jsp'.freeze

          def initialize(session:, bank_login:)
            @session = session
            @bank_login = bank_login
          end

          def login
            raise 'This login lacks security credentials' if bank_login.credentials.blank?
            return false unless session.current_path.blank?

            session.visit LOGIN_PATH

            session.within '#loginForm' do
              session.find('input[name="userid"]').set(user_id)
              session.find('input[name="password"]').set(password)
              session.click_on 'Login'
            end

            true
          end

          private

          attr_reader :session, :bank_login

          def user_id
            bank_login.credentials[:user_id]
          end

          def password
            bank_login.credentials[:password]
          end
        end
      end
    end
  end
end
