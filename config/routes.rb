Rails.application.routes.draw do
  root to: "logins#new"
  resource :login, only: [:new, :create, :destroy]

  resources :messages, only: [:index, :create]

  # Sidekiq dashboard
  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"
end
