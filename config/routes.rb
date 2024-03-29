Rails.application.routes.draw do
  
  root "posts#index"

  resources :posts, shallow: true do 
    collection do  # ルーティングに id が必要無いので collection を使用
      get :search
    end
    resources :comments
  end

  
  resources :users, only: %i[index new create show]

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  delete '/logout' => "sessions#destroy"

  resources :likes, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]

  namespace :mypage do
    resource :account, only: %i[edit update]
  end
end
