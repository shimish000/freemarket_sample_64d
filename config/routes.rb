Rails.application.routes.draw do

  # root to: 'products#index'
  root to: 'buys#show'

  resources :products, only: [:show] do
    resources :buys, only: [:index]
    resources :sells, only: [:new, :create]
  end
  
end