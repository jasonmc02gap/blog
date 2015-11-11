Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :users
  
  get "/sign-in",to: "sessions#new", as: :sign_in
  get "/log-out", to: "sessions#destroy", as: :log_out
  root 'posts#index'
end
