Rails.application.routes.draw do

  root to: 'sells#new'


  resources :products, only: [:show] do
    resources :buys, only: [:index]
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  
  resources :sells, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :destroy] 
  resources :cards, only: [:create, :new] 
  
end

