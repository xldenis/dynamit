require 'sidekiq/web'
Dynamite::Application.routes.draw do
  get '/auth/:provider/callback',to: 'sessions#create'
  get '/landing',to: 'landing#index'
  delete '/logout', to: 'sessions#destroy'
  root :to => "sources#index"
  mount Sidekiq::Web, at:"/sidekiq"
    namespace :api,:provides => :json do
      resources :users
      resources :posts
      post 'posts/track/', to:'posts#track'
  end
end
