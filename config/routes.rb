Rails.application.routes.draw do
  get 'accounts/show'

  get 'budgets/index'

  root to: 'budgets#index'
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  resources :reconciliations, path: :reconcile, only: [:index, :new, :create]
  resources :accounts
  resources :budgets
  resources :accounts
  namespace :transaction do
    resources :expenses
    resources :incomes
  end
end
