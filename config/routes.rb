Rails.application.routes.draw do

  root to: 'products#index'
  

  resources :products, only: [:show] do
    resources :buys, only: [:index]
    resources :sells, only: [:new, :create]
  end
  resources :users, only: [:index, :destroy] 
  resources :cards, only: [:create, :new]
  
end

