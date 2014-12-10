Rails.application.routes.draw do

  # auth
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }

  ActiveAdmin.routes(self)

  # API routes
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :proposals do
        member do
          post "approve"
        end
      end
      resources :comments, only: [:index, :create, :destroy]
      resources :themes, only: [:index, :show]
      resources :users, only: [:index, :show]
      resources :notifications, only: [:index] do
        collection do
          get 'check_new'
        end
      end
    end
  end

  post "flag" => "application#flag"
  post "vote" => "application#vote"

  get "/*path" => redirect("/?goto=%{path}")
  root "application#home"
end
