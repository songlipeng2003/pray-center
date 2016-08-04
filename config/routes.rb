Rails.application.routes.draw do
  root 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # api
  mount API => '/api'

  mount GrapeSwaggerRails::Engine => '/swagger'

  authenticate :admin_user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
