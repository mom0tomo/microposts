Rails.application.routes.draw do
  root to: 'tops#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # users/newではなくusers/signupを使う
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create]

  resources :microposts, only: [:create, :destroy]
end
