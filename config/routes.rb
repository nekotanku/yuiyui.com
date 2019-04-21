Rails.application.routes.draw do

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  get '/'=>"home#top"
  get "about"=>"home#about"
  
  get "posts/index"=>"posts#index"
  get "posts/new"=>"posts#new"
  post "posts/create"=>"posts#create"
  get "posts/:id"=>"posts#show"
  get "posts/:id/edit"=>"posts#edit"
  post "posts/:id/update"=>"posts#update"
  post "posts/:id/destroy"=>"posts#destroy"
  
  get "users/signup"=>"users#new"
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users
  resources :posts
end
