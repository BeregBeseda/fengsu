Rails.application.routes.draw do                
  match '/',                               to: 'menus#index',                                       via: 'get'  
  match 'about/',                          to: 'menus#index',                                       via: 'get'          
  
    
  match 'about/:translit',                 to: 'orders#a_new_order',                                via: 'get'  
  post '/orders/',                         to: 'orders#create'                     # for OrderForm works (path for creating new order)
  match '/click_for_pay',                  to: 'pays#b_page_for_select_pay_way',                    via: 'get'
  match '/confirm_pay/:name/:akey/:id',    to: 'orders#c_form_for_get_consult_after_pay',           via: 'get'    
  resources 'orders'                                                               # needs just! OrderUpdate path 
  match '/request_sent/:id',               to: 'orders#d_pay_info_success_sent',                    via: 'get'  
  
  match '/payed/:akey/:id/:akey_payed',    to: 'orders#order_is_payed',                             via: 'get'    
  
  patch '/ccccheck/:id', to: 'orders#ccc_check', via: 'get'                
    
    
    
  root 'menus#index'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
    
  match "*path",                           to: 'menus#index',                                        via: 'get'
end
