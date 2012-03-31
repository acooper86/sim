Sim::Application.routes.draw do
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users

  root :to => "pages#home"
  
  match 'support', :to => "pages#support"

  match '/about', :to => "pages#about"

  match '/contact', :to => "pages#contact"
  
  match '/affliate', :to => "pages#affliate"
  
  match '/support', :to => "pages#support"
  
  match '/signup', :to => "users#new"
  
  match '/signin', :to => "sessions#new"
  
  match '/signout', :to => "sessions#destroy"

 end
