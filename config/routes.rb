Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :orders, only: [:show] do
    get 'cancel', on: :member
    patch 'finish_cancel', on: :member
    patch 'approve', on: :member
  end
  resources :customers
end
