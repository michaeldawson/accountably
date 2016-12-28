Rails.application.routes.draw do
  root to: 'budget#show'
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  resources :reconciliations, path: :reconcile, only: [:index, :new, :create]
  resource :budget, controller: :budget
  resources :accounts, except: :index do
    get :reconcile, on: :collection
  end
  namespace :transaction do
    resources :expenses
    resources :incomes
  end

  namespace :bank do
    resources :accounts
  end

  namespace :api do
    namespace :int do
      resources :accounts, only: [:index, :update]
    end
  end

  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'michaeldawson' && password == 'sidekiq is fun'
  end
  mount Sidekiq::Web => '/sidekiq'
end
