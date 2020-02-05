Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :customers
  resources :users, only: %i[index edit update]
end
