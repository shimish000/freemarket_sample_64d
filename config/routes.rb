Rails.application.routes.draw do

  root to: 'sells#new'


  resources :products, only: [:show] do
    resources :buys, only: [:index]
  end
  
  resources :sells, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :destroy] 
  resources :cards, only: [:create, :new] 
  
end

