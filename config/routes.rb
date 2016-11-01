Rails.application.routes.draw do
  root to: 'budget#show'
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  resources :reconciliations, path: :reconcile, only: [:index, :new, :create]
  resource :budget, controller: :budget
  resources :accounts do
    get :reconcile, on: :collection
  end
  namespace :transaction do
    resources :expenses
    resources :incomes
  end

  namespace :bank do
    resources :accounts
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
