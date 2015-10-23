Rails.application.routes.draw do              
  match '/',                                             to: 'menus#index',   via: 'get'  
  match 'about/',                                        to: 'menus#index',   via: 'get'          
  match 'about/:translit',                               to: 'orders#new',    via: 'get'      
  
  root 'menus#index'
    
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
  
  
  match "*path", to: 'menus#index',   via: 'get'
  
  #match '/:random1',                                     to: 'menus#index',   via: 'get'
  #match '/:random1/:random2',                            to: 'menus#index',   via: 'get'  
  #match '/:random1/:random2/:random3',                   to: 'menus#index',   via: 'get'      
  #match '/:random1/:random2/:random3/:random4',          to: 'menus#index',   via: 'get'        
  #match '/:random1/:random2/:random3/:random4/:random5', to: 'menus#index',   via: 'get'
end
