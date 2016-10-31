class BankReconciliationWorker
  include Sidekiq::Worker

  def perform(bank_account_id, since: nil)
    Bank::Account.find(bank_account_id).reconcile(since: since)
  end
end
