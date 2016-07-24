Rails.application.routes.draw do
  devise_for :admin_users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # api
  mount API => '/api'

  mount GrapeSwaggerRails::Engine => '/swagger'

  authenticate :admin_user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
