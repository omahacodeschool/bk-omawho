Omawho::Application.routes.draw do

  get "about" => "site_pages#about", :as => "about"
  get "contact" => "site_pages#contact", :as => "contact"

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :users
  resources :sessions
  resources :images
  resources :password_resets, only: [:create, :edit, :update]
  
  resources :events do
    post "attend" => "events#attend", :as => :attend
    put "approve" => "events#approve", :as => :approve
  end
  
  get "about" => "site_pages#about", :as => :about
  get "contact" => "site_pages#contact", :as => :contact
  get "rss_feed" => "site_pages#rss_feed", :as => :rss_feed
  
  root :to => 'users#index'
  
  match ':username' => 'users#show', :as => :view_profile

end
