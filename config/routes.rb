Rails.application.routes.draw do
  devise_for :owner_users
  devise_for :customer_users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
