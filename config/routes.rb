Rails.application.routes.draw do
  devise_for :users
  resources :likes
  resources :follow_requests
  
  resources :comments
  resources :photos
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "photos#index"
  # root to: "home#index"
end
