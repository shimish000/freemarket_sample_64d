Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'phones', to: 'users/registrations#new_phone'
    post 'phones', to: 'users/registrations#create_phone'
  end
  root to: 'products#index'

  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    resources :buys, only: [:index]
    resources :sells, only: [:index, :new, :create, :edit, :update, :destroy] 
  end

  resources :users, only: [:index, :destroy] do
    resources :addresses, only: [:new, :create]
    resources :cards, only: [:create, :new]
  end
  resources :categories, only: [:index, :new]

  

end


