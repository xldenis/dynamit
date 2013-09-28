Dynamite::Application.routes.draw do
  get '/auth/:provider/callback',to: 'sessions#create'
  root :to => "feeds#index"
  
  shallow do
    namespace :api,:provides => :json do
      resources :users do
        resources :sources do
          resources :posts
        end
      end
    end
  end

end
