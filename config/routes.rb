Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'about' => 'home#about'
  get 'users/signup' => 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  resources :posts 
  resources :comments, only: [:create]
  resources :likes, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  class AuthenticatedConstraint
    def matches?(request)
      request.session['user_id'].present?
    end
  end
  
  constraints AuthenticatedConstraint.new do
    root to: 'posts#index', as: :user_root
  end
  root to: 'home#top'
end
