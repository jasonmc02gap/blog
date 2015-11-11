Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :users
  resources :sessions
  get "/sign-in",to: "sessions#new", as: :sign_in
  root 'posts#index'
end
