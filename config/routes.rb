Ambassadors::Application.routes.draw do
  resources :credit_types

  resources :event_types

  resources :events

  devise_for :users
  resources :users, :except => [:destroy, :create, :new]

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

end
