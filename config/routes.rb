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
    resources :buyers, only: [:index] do
      collection do
        get 'create', to: 'buyers#create'
        post 'pay', to: 'buyers#pay'
      end
    end
  end 
  
  resources :users, only: [:index, :destroy] do
    resources :addresses, only: [:new, :create]
    resources :cards, only: [:index, :new, :create, :show, :destroy] do
      collection do
        post 'pay', to: 'cards#pay'
      end
    end
  end

  resources :categories, only: [:index, :new]

end


