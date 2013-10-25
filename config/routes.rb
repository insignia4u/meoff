Meoff::Application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  devise_scope :user do
    get "/users/sign_out", :to => "devise/sessions#destroy"
  end

  resources :notifications

  get '/alert-the-team',	to: 'notifications#new'

  root to: 'home#index'
end
