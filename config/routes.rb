Rails.application.routes.draw do
  get 'otp', to: 'sessions#otp'
  post 'verify_otp', to: 'sessions#verify_otp'
  resources :posts
  get 'home/index'
  devise_for :users

  post '/posts/:id/like', to: 'posts#like', as: 'like_post'
  root to: "home#index"
  get '/feeds', to: 'home#feed', as: 'home_feed'
end
