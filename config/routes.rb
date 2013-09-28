require 'sidekiq/web'
Dynamite::Application.routes.draw do
  get '/auth/:provider/callback',to: 'sessions#create'
  root :to => "sources#index"
  mount Sidekiq::Web, at:"/sidekiq"
    namespace :api,:provides => :json do
      resources :users do
        resources :sources,shallow: true do
          resources :posts
        end   
      end
      resources :posts
    end
end
