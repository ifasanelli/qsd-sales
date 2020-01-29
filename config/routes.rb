Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :orders, only: [:index, :new, :create] 
end
