namespace :accounts do
  task reconcile_all: :environment do
    Bank::Account.all.each do |bank_account|
      BankReconciliationWorker.perform_async(bank_account.id)
    end
  end
end
