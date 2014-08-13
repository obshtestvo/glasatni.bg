Rails.application.routes.draw do

  resources :badges

  devise_for :users
  resources :users, :only => [:show]

  resources :proposals

  resources :themes

  root "themes#index"
end
