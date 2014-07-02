PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end

  get 'register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

 resources :categories, only: [:create, :show, :new]
 resources :users, only: [:show, :create, :edit, :update]




end
