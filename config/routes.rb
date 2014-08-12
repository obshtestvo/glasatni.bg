Rails.application.routes.draw do

  resources :badges

  devise_for :users
  resources :proposals

  resources :themes

  root "application#home"
end
