Rails.application.routes.draw do
  resources :tags
  resources :categories
  resources :posts
  devise_for :users
  get 'public/index'

  # namespace :admin do 
  #   # resources :posts
  #   get '/posts', to: 'posts#index'
  # end

  root to: "public#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
