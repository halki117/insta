Rails.application.routes.draw do
  
  root "posts#index"

  resources :posts, shallow: true do 
    collection do
      get :search
    end
    resources :comments
  end
  resources :users
  

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  delete '/logout' => "sessions#destroy"

  resources :likes, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
end
