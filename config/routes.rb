Rails.application.routes.draw do                

  match '/',                               to: 'menus#index',                                       via: 'get'  
  post '/',                                to: 'menus#index'           
  
  match 'about/',                          to: 'menus#index',                                       via: 'get'               
  match 'about/:translit/:show_visit_email',to: 'orders#a_new_order',                                via: 'get'  
  post  '/orders',                         to: 'orders#create'                     # for OrderForm works (path for creating new order)
  
  post '/i_have_payed',                    to: 'orders#b_test_for_get_consult_after_pay'           
  
  post '/test/:number/:ill_group/:good_group/:order_id/:order_akey', 
                                           to: 'tests#load_page'     
    
    
  root 'menus#index'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
    
  match "*path",                           to: 'menus#index',                                       via: 'get'
end
