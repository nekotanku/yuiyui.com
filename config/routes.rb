Rails.application.routes.draw do

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get '/'=>"home#top"
  get "about"=>"home#about"
  get "posts/index"=>"posts#index"
  get "posts/new"=>"posts#new"
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get "users"=>"users#index"
  get "users/signup"=>"users#new"
  resources :users
end
