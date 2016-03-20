Rails.application.routes.draw do                

  match '/',                               to: 'menus#index',                                       via: 'get'  
  post '/',                                to: 'menus#index'           
  
  match 'about/',                          to: 'menus#index',                                       via: 'get'               
  match 'about/:translit',                  to: 'orders#a_new_order',                               via: 'get'  
  post 'about/:translit',                  to: 'orders#a_new_order'                                
  post  '/orders',                         to: 'orders#create'                     # for OrderForm works (path for creating new order)
  
  post '/i_have_payed',                    to: 'orders#b_test_for_get_consult_after_pay'           
  
  post '/test/:qw_number/:order_id/:order_akey/:al/:nl/:shl/:pl/:gml/:dl/:ml/:ol/:kl/:il/:disl', 
                                           to: 'tests#load_page'     
    
    
  root 'menus#index'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
    
  match "*path",                           to: 'menus#index',                                       via: 'get'
end
