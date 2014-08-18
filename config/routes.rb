Rails.application.routes.draw do

  resources :badges

  devise_for :users
  resources :users, :only => [:show]

  resources :comments do
    collection do
      post 'vote'
    end
  end

  resources :proposals do
    collection do
      post 'vote'
    end
  end

  get "admin" => "application#admin"

  resources :themes

  get "about" => "application#about"

  root "themes#index"
end
