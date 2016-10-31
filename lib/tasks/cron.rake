namespace :cron do
  task daily: ['accounts:reconcile_all']
end
