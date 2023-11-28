Rails.application.routes.draw do
  # resources :views
  # resources :answers
  # resources :comments
  # resources :posts
  resources :specializations
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  # Registration and login routes
  post '/login', to: 'registration#login'
  post '/register', to: 'registration#register'

  # Post routes
  get '/posts/:id', to: 'posts#index'
  get '/post/:u_id/:p_id', to: 'posts#show'
  post '/posts/', to: 'posts#create'
  delete '/posts/:id', to: 'posts#destroy'

  # Comment routes
  get '/comments/:id', to: 'comments#index'
  post '/comments', to: 'comments#create'
  post '/comments_like', to: 'comments#like'
  delete '/comments/destroy/:id', to: 'comments#destroy'

  # User extra routes
  put '/user/profile_image', to: 'users#profile_image'
  get '/user/:id', to: 'users#user_data'
  get '/user/:id/followers', to: 'users#followers'
  get '/user/follow/:other', to: 'users#follow'
  get '/user/unfollow/:other', to: 'users#unfollow'
end
