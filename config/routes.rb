Rails.application.routes.draw do
  
  resources :posts, shallow: true do 
    resources :comments
  end
  resources :users
  root "posts#index"

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  delete '/logout' => "sessions#destroy"

  resources :likes, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]

  post 'posts/search' => "searches#index", as: :searches
end
