module Bank
  module Adapter
    class Selenium
      private

      def session
        @session ||= Capybara::Session.new(:chrome)
      end

      def cleanup
        session.driver.browser.close
      end
    end
  end
end
