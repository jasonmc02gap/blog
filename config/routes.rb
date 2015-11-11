Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :users

  
  get "/sign-in",to: "sessions#new", as: :sign_in
  get "/log-out", to: "sessions#destroy", as: :log_out
  get "/new", to: "sessions#new"
  post "/create", to: "sessions#create", as: :create_session
  get "my-posts", to: "posts#my_posts", as: :my_posts
  get "my-comments", to: "comments#my_comments", as: :my_comments
  root 'posts#index'
end
