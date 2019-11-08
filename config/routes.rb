Rails.application.routes.draw do
  root to: "pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Sidekiq dashboard
  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"
end
