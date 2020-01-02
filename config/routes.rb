Rails.application.routes.draw do

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

end
