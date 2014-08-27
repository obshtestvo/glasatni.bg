Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :proposals
      resources :comments
    end
  end

  resources :badges

  devise_for :users
  resources :users, :only => [:show]

  resources :comments

  resources :proposals

  get "admin" => "application#admin"
  post "vote" => "application#vote"

  resources :themes

  get "about" => "application#about"

  root "themes#index"
end
