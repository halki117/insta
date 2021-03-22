Rails.application.routes.draw do
  
  resources :posts
  resources :users, only: [:new, :create]
  root "posts#index"

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  delete '/logout' => "sessions#destroy"
end
