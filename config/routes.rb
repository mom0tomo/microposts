Rails.application.routes.draw do
  root to: 'tops#index'

  # users/newではなくusers/signupを使う
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # resources :sessions, only: [:new, :create, :destroy]
end
