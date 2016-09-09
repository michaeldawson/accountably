Rails.application.routes.draw do
  get 'accounts/show'

  get 'budgets/index'

  root to: 'budgets#index'
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  resources :accounts
  resources :budgets
  resources :accounts
  namespace :transaction do
    resources :expenses
    resources :incomes
  end
end
