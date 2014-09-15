Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :proposals
      resources :themes, only: [] do
        get "proposals_count"
      end
      resources :comments
    end
  end

  #devise_for :users#, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:show]

  resources :badges
  resources :themes
  resources :proposals

  post "vote" => "application#vote"
  get "about" => "application#about"

  root "themes#index"
end
