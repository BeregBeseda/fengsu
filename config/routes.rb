Rails.application.routes.draw do                

  match '/',                               to: 'menus#index',                                       via: 'get'  
  post '/',                                to: 'menus#index'           
  
  match 'about/',                          to: 'menus#index',                                       via: 'get'               
  match 'about/:translit',                 to: 'orders#a_new_order',                                via: 'get'  
  post 'about/:translit',                  to: 'orders#a_new_order'                                
  post  '/orders',                         to: 'orders#create'                     # for OrderForm works (path for creating new order)
  
  post '/i_have_payed/:details',           to: 'orders#b_test_for_get_contacts_after_pay'
  
  
  
  post '/test/:test_url_encoded',          to: 'tests#load_page'
  match '/test/:test_url_encoded',         to: 'tests#load_page',                                   via: 'get'    

  match '/much_form/:order_info',          to: 'contacts#more_info_form',                           via: 'get'        
  post  '/contacts',                       to: 'contacts#create'                     # for MoreContactsForm works (path for creating new contact)  
  match '/contacts/:details',              to: 'contacts#show',                                     via: 'get'      
                                               
  
    
  root 'menus#index'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
    
  match "*path",                           to: 'menus#index',                                       via: 'get'
end
