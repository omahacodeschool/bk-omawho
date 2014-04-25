Omawho::Application.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :users 
  
  resources :sessions
  resources :images
  resources :password_resets, only: [:create, :edit, :update]
  
  resources :events do
    post "attend" => "events#attend", :as => :attend
    post "approve" => "events#approve", :as => :approve
  end
  
  get "about" => "site_pages#about", :as => :about
  get "contact" => "site_pages#contact", :as => :contact
  get "rss_feed" => "site_pages#rss_feed", :as => :rss_feed
  get "search_results" => "site_pages#search", :as => :name_search  
  get "name_game" => "site_pages#name_game", :as => :name_game
  post "check_quiz" => "site_pages#check_quiz", :as => :check_quiz
  
  get "responsivetemplate" => "users#responsivetemplate"
  
  root :to => 'users#index'
  
  get ':username' => 'users#show', :as => :view_profile

end
