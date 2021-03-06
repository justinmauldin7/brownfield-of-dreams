Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/login', to: "sessions#new", as: 'login'
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  post '/friends/:friend_id', to: "friendships#create", as: "friendships"


  patch '/activate/:id', to: 'activation#update', as: 'account_activation'
  get '/activate/:id', to: 'activation#edit', as: 'account_activation_landing'
  get '/activate', to: 'activation#show', as: 'activation_success'

  get '/invite', to: 'invite#new', as: 'new_invite'
  post '/invite', to: 'invite#create', as: 'invite'

  get 'auth/github', as: :github_login
  get '/auth/github/callback', to: 'auth/github/user_token#create'

  get '/dashboard', to: 'users#show'
  get '/get_started', to: 'get_started#show', as: "get_started"

  resources :users, only: [:new, :create, :update, :edit]

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only:[:create, :destroy]
end
