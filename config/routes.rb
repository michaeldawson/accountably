Rails.application.routes.draw do
  root to: 'budget#show'
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  resources :reconciliations, path: :reconcile, only: [:index, :new, :create]
  resources :accounts
  resource :budget, controller: :budget
  resources :accounts
  namespace :transaction do
    resources :expenses
    resources :incomes
  end

  namespace :bank do
    resources :accounts
  end
end
