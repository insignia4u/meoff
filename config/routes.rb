Meoff::Application.routes.draw do
  get "home/index"

  devise_for :users

  resources :notifications

  get "/alert-the-team",	to: "notifications#new"

  root to: "home#index"
end
