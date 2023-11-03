Rails.application.routes.draw do
  # resources :views
  # resources :answers
  # resources :comments
  # resources :posts
  resources :specializations
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  post '/login', to: 'registration#login'
  post '/register', to: 'registration#register'

  # User extra routes
  put '/user/profile_image', to: 'users#profile_image'
  get '/user/:id', to: 'users#user_data'
  get '/user/:id/followers', to: 'users#followers'
end
