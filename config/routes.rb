Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  post 'public/comments/:post_id', to: 'public#comments', :as => :comments

  get "posts/process_post", as: "process_post"
  get "public/tags/:tag", to: "public#tags", :as => :tag_search
  get "public/category/:category/posts", to: "public#category", :as => :category_search
  get "public/read/:id/", to: "public#read", :as => :post_read
  
  resources :tags 
  resources :categories
  resources :posts do 
    collection do 
      post 'publish', :action => "publish"
    end
  end
  

  devise_for :users

  get 'public/index'

  namespace :admin do 
    # resources :posts
    get '/posts', to: 'posts#index'
  end

  root to: "public#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
