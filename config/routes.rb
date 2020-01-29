Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :costumers, only: %i[index show new create]
end
