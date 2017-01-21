require 'site_prism'
require 'capybara/dsl'

class NABTransactionsPage < SitePrism::Page
  set_url 'file:///Users/michaeldawson/Documents/Accountably/Transaction%20history%20cache.htm'
  element :next_page_link, '#someItems'

  sections :transactions, TransactionSection, '#transactionHistoryTable tbody tr'

  # Reconcile transactions on this page. Stop if we've encountered 3 success transactions that were already in
  # the system, or if there are no next pages.
  def reconcile(bank_account:, since: nil)
    loop do
      success = parse_page(bank_account, accept_transactions_since: since)

      break unless success
      break unless next_page
    end
  end

  private

  attr_reader :session

  def parse_page(bank_account, accept_transactions_since: nil)
    successive_failures = 0

    transactions.each do |transaction|
      success = Bank::Transaction.new(
        transaction_data: transaction.data,
        bank_account: bank_account,
        accept_transactions_since: accept_transactions_since,
      ).parse!

      if success
        successive_failures = 0
      else
        successive_failures += 1
      end

      return false if successive_failures == 3
    end

    true
  end

  def next_page
    return false unless has_next_page_link?

    click_on next_page_link

    true
  end
end
