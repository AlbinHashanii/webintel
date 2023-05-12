Rails.application.routes.draw do
  resources :articles
  resources :categories, except: [:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#home"
  get "/about", to: "welcome#about"

  #Sign up
  get '/signup', to: 'users#new'

  #LOGIN
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:new]
end
