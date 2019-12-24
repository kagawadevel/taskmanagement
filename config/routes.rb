Rails.application.routes.draw do

  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  root to: 'tasks#index'

  resources :tasks do
    collection do
      post :confirm
    end
  end

end
