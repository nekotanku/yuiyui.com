Rails.application.routes.draw do

  get '/'=>"home#top"
  get "about"=>"home#about"
  get "posts/index"=>"posts#index"
  get "posts/new"=>"posts#new"
  post "posts/create"=>"posts#create"
  get "posts/:id"=>"posts#show"
  get "posts/:id/edit"=>"posts#edit"
  post "posts/:id/update"=>"posts#update"
  post "posts/:id/destroy"=>"posts#destroy"
  get "users/index"=>"users#index"
  get "users/signup"=>"users#new"

end
