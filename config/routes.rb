Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :users

  
  get "/sign-in",to: "sessions#new", as: :sign_in
  get "/log-out", to: "sessions#destroy", as: :log_out
  get "/new", to: "sessions#new"
  post "/create", to: "sessions#create", as: :create_session
  root 'posts#index'
end
