Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :proposals, only: [:index, :show] do
        collection do
          get "count"
        end
      end
      resources :comments, only: [:index, :create, :destroy]
      resources :themes, only: [:index]
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:show]

  resources :badges
  resources :themes
  resources :proposals

  post "flag" => "application#flag"
  post "vote" => "application#vote"
  get "about" => "application#about"

  root "proposals#index"
end
