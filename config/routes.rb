Rails.application.routes.draw do

  root to: 'products#index'
  
  resources :products, only: [:show] do
    resources :buys, only: [:index]
    resources :sells, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get 'category_children' 
        get 'category_grandchildren'
      end
    end
  end

  resources :users, only: [:index, :destroy] 
  resources :cards, only: [:create, :new]
  resources :categories, only: [:index, :new]

end


