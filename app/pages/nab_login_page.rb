require 'site_prism'
require 'capybara/dsl'

class NABLoginPage < SitePrism::Page
  set_url 'https://ib.nab.com.au/nabib/index.jsp'

  element :user_id_field, 'input[name="userid"]'
  element :password_field, 'input[name="password"]'
  element :login_button, '.cta a'

  def login(bank_login)
    raise 'This login lacks security credentials' if bank_login.credentials.blank?

    user_id_field.set(bank_login.credentials[:user_id])
    password_field.set(bank_login.credentials[:password])
    login_button.click

    true
  end
end
