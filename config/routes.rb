Meoff::Application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { 
    :invitations   => 'users/invitations', 
    :registrations => 'users/registrations' 
  }

  resources :notifications

  get '/alert-the-team',	to: 'notifications#new'

  authenticated :user do
    root to: 'notifications#index', as: :authenticated_root
  end

  root to: 'home#index'
end
