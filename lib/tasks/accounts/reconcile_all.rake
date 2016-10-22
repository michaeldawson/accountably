namespace :accounts do
  task reconcile_all: :environment do
    Bank::Account.all.each(&:reconcile)
  end
end
