Rails.application.routes.draw do

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  get '/'=>"home#top"
  get "about"=>"home#about"
  
  post "posts/:id/update"=>"posts#update"
  
  get "users/signup"=>"users#new"
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :posts
end
