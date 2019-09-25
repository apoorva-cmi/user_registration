Rails.application.routes.draw do
  root 'home#index'
  
  resources :users

  resources :sessions, :only => [:create]

  resources :password_resets
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
