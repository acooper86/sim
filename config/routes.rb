Sim::Application.routes.draw do

  resources :sessions, :only => [:new, :create, :destroy]
 
  resources :users do
  	
  	member do
  		match '/activate', :to => "users#activate"
  	    match '/mail', :to => "users#mail"
  	    match '/support', :to => "users#support"
  	end
  	
  	resources :direct_mail
  	
  	resources :news_mail
  	
  	resources :images
  	
  	resources :contacts
  	
  	resource :blogs do
  		resources :posts
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
  
  match '/signup', :to => "users#new"
  
  match '/dashboard', :to => "users#dashboard"
  
  match '/about', :to => "statics#about"
  
  match '/affliate', :to => "statics#affliate"
  
  match 'contact' => "contact#new", :as => 'contact', :via => :get
  
  match 'contact' => "contact#create", :as => 'contact', :via => :post
  
  match '/signin', :to => "sessions#new"
  
  match '/signout', :to => "sessions#destroy"

 end
