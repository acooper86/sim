Sim::Application.routes.draw do

  resources :sessions, :only => [:new, :create, :destroy]
 
  resources :users do
  	member do
  		match '/activate', :to => "users#activate"
  	end
  	
  	resource :websites do
  		member do
  			match '/publish', :to => "websites#publish", :via => :post
  		end
  		resources :pages 
  	end
  end
  
  resources :password_resets
  
  

  root :to => "statics#home"
  
  match '/about', :to => "statics#about"
  
  match '/affliate', :to => "statics#affliate"
  
  match 'contact' => "contact#new", :as => 'contact', :via => :get
  
  match 'contact' => "contact#create", :as => 'contact', :via => :post
  
  match '/dashboard', :to => "users#dashboard"
  
  match '/signup', :to => "users#new"
  
  match '/support', :to => "users#support"
  
  match '/signin', :to => "sessions#new"
  
  match '/signout', :to => "sessions#destroy"

 end
