Dynamite::Application.routes.draw do
  get '/callback/:provider',to: 'sessions#create'
end
