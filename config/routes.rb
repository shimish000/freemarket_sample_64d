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
    resources :sells, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  resources :users, only: [:index, :destroy] 
  resources :cards, only: [:create, :new]
  
end

