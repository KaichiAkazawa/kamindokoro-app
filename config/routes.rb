Rails.application.routes.draw do
  devise_for :customer_users, controllers: {
    sessions: 'customer_users/sessions',
    passwords: 'customer_users/passwords',
    registrations: 'customer_users/registrations'
  }
  devise_scope :customer_user do
    post 'customer_users/guest_sign_in', to: 'customer_users/sessions#guest_sign_in'
  end

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
      get 'keyword_search'
    end
  end
  resources :tags do
    get 'tag_search', to: 'stores#tag_search'
  end
  resources :customer_users, only: [:index, :show]
  
end
