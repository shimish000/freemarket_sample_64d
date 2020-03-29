Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'phones', to: 'users/registrations#new_phone'
    post 'phones', to: 'users/registrations#create_phone'
  end
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

  resources :users, only: [:index, :destroy] do
    resources :addresses, only: [:new, :create]
    resources :cards, only: [:create, :new]
  end
  resources :categories, only: [:index, :new]
  

end


