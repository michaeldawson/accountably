module Bank::Adapter::Selenium::NAB::Page
  class Login
    def initialize(session)
      @session = session
    end

    def login(user_id, password)
      session.within '#loginForm' do
        session.find('input[name="userid"]').set(user_id)
        session.find('input[name="password"]').set(password)
        session.click_on 'Login'
      end
    end

    private

    attr_reader :session, :user_id, :password
  end
end
