Rails.application.routes.draw do

  root to: 'sessions#new'

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users

  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :sessions

  namespace :administrator do
    resources :users
  end

  resources :labels, only:[:new,:create,:edit,:update,:destroy]

end
