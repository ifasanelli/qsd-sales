Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :orders, only: [:show] do
    patch 'finish_cancel', on: :member
    get 'cancel', on: :member
  end
  resources :customers
end
