Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :orders, only: %i[index show new create edit update]
end
