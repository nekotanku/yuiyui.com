Rails.application.routes.draw do

  get '/'=>"home#top"
  get "about"=>"home#about"
  get "posts/index"=>"posts#index"
  get "posts/new"=>"posts#new"
  get "users"=>"users#index"
  get "users/signup"=>"users#new"

  resources :users
end
