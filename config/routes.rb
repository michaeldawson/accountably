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
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'michaeldawson' && password == 'sidekiq is fun'
  end
  mount Sidekiq::Web => '/sidekiq'
end
