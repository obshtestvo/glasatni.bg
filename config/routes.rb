Rails.application.routes.draw do

  resources :badges

  devise_for :users
  resources :users, :only => [:show]

  resources :comments, :only => [:index, :create, :update, :destroy]

  resources :proposals

  resources :themes

  get "about" => "application#about"

  root "themes#index"
end
