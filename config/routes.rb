Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'cards#new'

  root to: 'cards#new'
  # root to: 'products#show'
  # root to: 'buys#index'
  resources :products, only: [:show] do
    resources :buys, only: [:index]
  end
  resources :users, only: [:index, :destroy]
  resources :cards, only: [:create, :new]
  
end

