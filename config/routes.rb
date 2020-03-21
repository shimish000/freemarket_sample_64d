Rails.application.routes.draw do

  root to: 'products#index'
  
  # root to: 'categories#index'

  resources :products, only: [:show] do
    resources :buys, only: [:index]
    resources :sells, only: [:new, :create]
    collection do
      get 'category_children' 
      get 'category_grandchildren'
    end
  end

  resources :users, only: [:index, :destroy] 
  resources :cards, only: [:create, :new]
  resources :categories, only: [:index]
end

