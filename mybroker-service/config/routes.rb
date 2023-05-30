Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/authenticity_token', to: 'application#authenticity_token'
  root "subscribers#index"
  #
  namespace :api do
    namespace :v1 do
      post 'new-subscriber', to: 'subscribers#create'
      post 'new-requested-quote', to: 'requested_quotes#create'
    end
  end
end
