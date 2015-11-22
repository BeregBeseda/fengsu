Rails.application.routes.draw do                
  match '/',                               to: 'menus#index',                    via: 'get'  
  match 'about/',                          to: 'menus#index',                    via: 'get'          
  match 'about/:translit',                 to: 'orders#new_order',               via: 'get'
  
  post '/orders/',                         to: 'orders#create'         # for OrderForm works (path for creating new order)
  resources 'orders'

  match '/click_for_pay',                  to: 'pays#page_for_select_pay_way',        via: 'get'
  match '/confirm_pay/:name/:akey/:id',    to: 'orders#form_for_get_consult_after_pay',  via: 'get'    
  
  match '/payed/:akey/:id/:akey_payed',    to: 'orders#order_is_payed',          via: 'get'                  
    
  root 'menus#index'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
    
  match "*path",                           to: 'menus#index',                    via: 'get'
end
