Rails.application.routes.draw do

  get 'relationships/create'

  get 'relationships/destroy'

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  get '/'=>"home#top"
  get "about"=>"home#about"
  
  get "users/signup"=>"users#new"
  resources :users do
    member do
      get :followings
      get :followers
    end
    
  end
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :posts 
  resources :comments, only: [:create]
  
  resources :likes, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
