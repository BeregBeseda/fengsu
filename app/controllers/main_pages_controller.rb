class MainPagesController < ApplicationController

  before_action :set_main_page_and_new_order, only: [:index]
#_____________________________________________________________________________________________________________________________________________

  
  
  def index 
    @site_title             = MeConstant.find_by_title('site_title').content
    
    root_path               = MeConstant.find_by_title('root_path').content      
    @prerender_page         = root_path 
  end
#_____________________________________________________________________________________________________________________________________________  
  
   
  private
  def set_main_page_and_new_order
    @main_page = MainPage.find(1)       
    @order = Order.new      
  end          
end
