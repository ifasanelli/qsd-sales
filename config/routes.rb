Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :orders, only: [:index, :show, :new, :create] 
end
