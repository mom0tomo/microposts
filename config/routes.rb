Rails.application.routes.draw do
  root to: 'tops#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    # フォロー中のユーザとフォローされているユーザ一覧を表示するページは必要
    member do
      get :followings
      get :followers
      get :likes
    end
  end

  resources :microposts, only: [:index, :create, :destroy]

  # 中間テーブルなのでindexやshowはない
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
