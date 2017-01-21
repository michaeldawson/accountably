require 'site_prism'
require 'capybara/dsl'

class NABAccountsPage < SitePrism::Page
  class AccountsSection < SitePrism::Section
    element :title, 'a.accountNickname'
    element :details, '.accountNumber'
  end

  # set_url 'https://ib.nab.com.au/nabib/acctInfo_acctBal.ctl'
  set_url 'file:///Users/michaeldawson/Documents/Accountably/Account%20summary%20cache.htm'

  sections :accounts, AccountsSection, '.acctDetails'

  def open_account(bank_account)
    account(bank_account.name).title.click
  end

  private

  def account(account_name)
    accounts.detect { |account_row| account_row.title.text == account_name }
  end
end
