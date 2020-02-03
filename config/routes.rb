Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources  :customers, only: %i[index] do
    get 'search', on: :collection
    resources :orders, only: %i[new create]
  end
  resources :orders, only: %i[index show edit update]
end
