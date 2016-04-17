class MainPagesController < ApplicationController

  before_action :set_pages_and_new_order, only: [:index]
#_____________________________________________________________________________________________________________________________________________

  
  
  def index 
    @site_title             = MeConstant.find_by_title('site_title').content
    
    root_path               = MeConstant.find_by_title('root_path').content      
    @prerender_page         = root_path 
  end
#_____________________________________________________________________________________________________________________________________________  
  
   
  private
  def set_pages_and_new_order
    @main_page  = MainPage.find(1)       
    @page       = Page.find_by_page :main
    @order      = Order.new      
  end          
end
