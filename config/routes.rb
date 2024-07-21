Rails.application.routes.draw do
  get 'categories/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'home#index'
  
  get '/pages/contact', to: 'pages#show', defaults: { title: 'Contact Us' }
  get '/pages/about', to: 'pages#show', defaults: { title: 'About Us' }

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
end
