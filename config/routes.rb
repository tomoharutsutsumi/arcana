Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
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
    resources :share_hashes, module: :lists
  end
  resources :restaurants
  resources :archived_lists do
    resources :archived_restaurants, module: :archived_lists
  end
  resources :shared_lists do
    resources :shared_restaurants, module: :shared_lists
  end
  # resources :requests do
  #   resources :shared_lists, module: :requests
  # end
end
