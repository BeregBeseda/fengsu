Rails.application.routes.draw do              
  match '/',                                             to: 'menus#index',   via: 'get'  
  match 'about/',                                        to: 'menus#index',   via: 'get'          
  match 'about/:translit',                               to: 'orders#new',    via: 'get'
  
  post '/orders/',                                       to: 'orders#create'               # for OrderForm works (path for creating new order)
  resources 'orders'

  match '/click_for_pay', to: 'pays#a_for_pay', via: 'get'
  match '/confirm_form/:name/:akey/:id', to: 'pays#b_after_pay_form', via: 'get'    
  match '/success_confirm', to: 'pays#c_success_confirm_form', via: 'get'    
  
  match '/payed/:akey/:id/:akey_payed', to: 'orders#order_is_payed', via: 'get'                  
    
  root 'menus#index'
  
    
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
    
  match "*path", to: 'menus#index',   via: 'get'
end
