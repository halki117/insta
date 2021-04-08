Rails.application.routes.draw do
  
  resources :posts, shallow: true do 
    resources :comments
  end
  resources :users, only: [:new, :create]
  root "posts#index"

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  delete '/logout' => "sessions#destroy"

  resources :likes, only: %i[create destroy]
end
