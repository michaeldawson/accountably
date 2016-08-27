Rails.application.routes.draw do
  get 'buckets/show'

  get 'budgets/index'

  root to: 'budgets#index'
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  resources :accounts
  resources :budgets
  resources :buckets
  resources :transactions
end
