Rails.application.routes.draw do

  root to: 'products#index'


  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :buys, only: [:index]
  end
  
  # resources :sells, only: [:index, :new]
  resources :users, only: [:index, :destroy] 
  resources :cards, only: [:create, :new] 
  
end

