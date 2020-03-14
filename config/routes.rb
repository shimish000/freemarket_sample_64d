Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cards#new'
  resources :users, only: [:index, :destroy]
  resources :cards, only: [:create, :new]
end
