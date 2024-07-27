Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'home#index'

  get '/pages/contact', to: 'pages#show', defaults: { title: 'Contact Us' }
  get '/pages/about', to: 'pages#show', defaults: { title: 'About Us' }

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
  resource :cart, only: [:show] do
    post 'add/:product_id', to: 'carts#add', as: 'add_to'
    delete 'remove/:product_id', to: 'carts#remove', as: 'remove_from'
    delete 'clear', to: 'carts#clear', as: 'clear'
  end
end
