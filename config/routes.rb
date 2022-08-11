require "sidekiq/pro/web"
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  root "recommend_projects#index"

  post 'login', to: "users#login", as: :login
  post 'logout', to: "users#logout", as: :logout
  get 'users/:id/projects', to: "users#projects", as: :user_projects

  resources :recommend_projects do
    post :add_comment, on: :member
    put :check, on: :member
    get :unchecked_projects, on: :collection
  end
end
