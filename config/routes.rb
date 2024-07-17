Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'home#index'
end
