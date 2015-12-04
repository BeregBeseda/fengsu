Rails.application.routes.draw do                
  match '/',                               to: 'menus#index',                                                          via: 'get'  
  match 'about/',                          to: 'menus#index',                                                          via: 'get'          
  
    
  match 'about/:translit',                 to: 'order_before_pay_checking#a_new_order',                                via: 'get'  
  post  '/orders/',                        to: 'order_before_pay_checking#create'                     # for OrderForm works (path for creating new order)
  match '/click_for_pay',                  to: 'pays#b_page_for_select_pay_way',                                       via: 'get'
  
  match '/i_have_payed/:name/:akey/:id',   to: 'order_before_pay_checking#c_form_for_get_consult_after_pay',           via: 'get'    
  patch '/save_pay_info/:id',              to: 'order_before_pay_checking#update_pay_data',                            via: 'get'                
  match '/request_sent/:id',               to: 'order_before_pay_checking#d_pay_info_success_sent',                    via: 'get'    
  
  match '/payed/:akey/:id/:akey_payed',    to: 'order_pay_is_checked#change_status_to_payed',                          via: 'get'    
      
    
    
  root 'menus#index'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)    
    
  match "*path",                           to: 'menus#index',                                       via: 'get'
end
