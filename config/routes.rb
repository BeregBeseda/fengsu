Rails.application.routes.draw do

  match '/', to: 'menus#index', via: 'get'  
  match 'about/', to: 'menus#index', via: 'get'          
  match 'about/:translit', to: 'orders#new', via: 'get'      
  
  root 'menus#index'
    
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
end
