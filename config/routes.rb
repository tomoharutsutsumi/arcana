Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'users/lists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :users do
    resources :searches
  end
  resources :users do
    resources :requests, module: :users
    resources :permission_lists, module: :users
    resources :permitted_lists, controller: 'users/permission_lists/permitted_lists'
    resources :lists, module: :users
  end
  resources :lists do
    resources :restaurants, module: :lists
  end
end
