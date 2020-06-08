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
      post 'saved_park', to: 'saved_parks#create'
      delete 'saved_park/:id', to: 'saved_parks#destroy'
      delete 'visit/:id', to: 'visit#destroy'
    end
  end


get '*path', to: "application#fallback_index_html", constraints: ->(request) do
!request.xhr? && request.format.html?
end

end
