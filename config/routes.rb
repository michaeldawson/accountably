Rails.application.routes.draw do
  get 'budgets/index'

  root to: 'budgets#index'
  devise_for :users

  resources :accounts
  resources :budgets
end
