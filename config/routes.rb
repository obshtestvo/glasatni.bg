Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :proposals
      resources :comments, only: [:index, :create, :destroy]
      resources :themes, only: [:index, :show]
      resources :users, only: [:index, :show]
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }

  resources :proposals, :only => [:index]

  post "flag" => "application#flag"
  post "vote" => "application#vote"
  get "about" => "application#about"

  root "proposals#index"
end
