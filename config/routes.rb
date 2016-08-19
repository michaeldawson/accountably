Rails.application.routes.draw do
  devise_for :users

  resources :accounts, only: :index
end
