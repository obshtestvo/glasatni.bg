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

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }
  resources :users, :only => [:show]
  resources :themes
  resources :proposals

  post "flag" => "application#flag"
  post "vote" => "application#vote"
  get "about" => "application#about"
  get "rank/:rank" => "application#rank",
    constraints: { rank: /observer|speaker|orator|enthusiast|activist|policy_maker/ }

  root "proposals#index"
end
