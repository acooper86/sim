Sim::Application.routes.draw do
  resources :users

  root :to => "pages#home"
  
  match 'support', :to => "pages#support"

  match '/about', :to => "pages#about"

  match '/contact', :to => "pages#contact"
  
  match '/affliate', :to => "pages#affliate"
  
  match '/support', :to => "pages#support"
  
  match '/signup', :to => "users#new"

 end
