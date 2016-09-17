module Bank
  module Adapter
    class Selenium
      def login
        raise NotImplementedError
      end

      private

      def method_missing(method_sym, *arguments, &block)
        session.send(method_sym, *arguments, &block)
      end

      def session
        @session ||= Capybara::Session.new(:chrome)
      end
    end
  end
end
