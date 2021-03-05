Rails.application.routes.draw do
  devise_for :customer_users, controllers: {
    sessions: 'customer_users/sessions',
    passwords: 'customer_users/passwords',
    registrations: 'customer_users/registrations'
  }

  devise_for :owner_users, controllers: {
    sessions: 'owner_users/sessions',
    passwords: 'owner_users/passwords',
    registrations: 'owner_users/registrations'
  }
  root to: 'stores#index'

  resources :stores, except: [:index] do
    resources :reviews, only: [:index, :create]
    resources :bookmarks, only: [:create, :destroy]
    collection do
      get 'tag_search'
    end
    collection do
      get 'store_search'
    end
  end
  resources :customer_users, only: [:index, :show]
  
end
