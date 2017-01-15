# require_dependency 'bank/adapter/selenium/nab/account/transaction'
require 'site_prism'
require 'capybara/dsl'

module NAB
  class AccountsPage < SitePrism::Page
    # set_url 'https://ib.nab.com.au/nabib/acctInfo_acctBal.ctl'
    set_url 'file:///Users/michaeldawson/Documents/Accountably/Account%20summary%20cache.htm'

    sections :accounts, AccountSection, '.acctDetails'
    class AccountSection < SitePrism::Section
      element :title, 'a.accountNickname'
      element :details, '.accountNumber'
    end

    def open_account(bank_account)
      click_on account(bank_account.name).title
    end

    private

    def account(account_name)
      accounts.select { |account_row| account_row.title.text == account_name }
    end
  end
end
