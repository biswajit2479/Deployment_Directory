Rails.application.routes.draw do

  #get 'users/index'
  #get 'users/edit'

  get 'sessions/create'
  get 'sessions/destroy'
  get 'home/show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :events do
    collection do
      post 'purge'
      post 'unpurge'
      post 'purge_passive_event'
      post 'filter'
    end
  end
  resources :users
  resources :companies
  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: "home#show"

end
