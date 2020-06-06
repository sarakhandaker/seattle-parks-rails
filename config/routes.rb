Rails.application.routes.draw do
  get '/check_user', to: 'application#check_user'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      get '/parks', to: 'parks#index'
      get '/parks/:id', to: 'parks#show'
      post '/visits', to: 'visits#create'
      patch '/visits/:id', to: 'visits#update'
      patch '/users/:id', to: 'users#update'
    end
  end
end
