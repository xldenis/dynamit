Dynamite::Application.routes.draw do
  get '/auth/:provider/callback',to: 'sessions#create'
  root :to => "feeds#index"
  

    namespace :api,:provides => :json do
      resources :users do
        resources :sources,shallow: true do
          resources :posts
        end
      end
    end

end
