Rails.application.routes.draw do
  get 'customer_users/show'
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

  resources :stores, except: [:index]

end
