Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get "posts/process_post", as: "process_post"
  get "public/tags/:tag", to: "public#tags", :as => :tag_search
  get "public/category/:category/posts", to: "public#category", :as => :category_search

  resources :tags 

  resources :categories
  resources :posts
  devise_for :users
  get 'public/index'

  namespace :admin do 
    # resources :posts
    get '/posts', to: 'posts#index'
  end

  root to: "public#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
