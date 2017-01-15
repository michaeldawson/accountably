require_dependency 'bank/adapter/selenium/nab'
require 'site_prism'
require 'capybara/dsl'

module NAB
  class LoginPage < SitePrism::Page
    set_url 'https://ib.nab.com.au/nabib/index.jsp'

    element :user_id_field, 'input[name="userid"]'
    element :password_field, 'input[name="password"]'

    def login(bank_login)
      raise 'This login lacks security credentials' if bank_login.credentials.blank?

      user_id_field.set(bank_login.credentials[:user_id])
      password_field.set(bank_login.credentials[:password])

      true
    end
  end
end
