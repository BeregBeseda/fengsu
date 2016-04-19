# encoding: utf-8
class OrderInfoPagesController < ApplicationController

  before_action :set_page_and_order_info_page, :set_site_title,  only: [:show]

  def show
  end
#_____________________________________________________________________________________________________________________________________________

  
    
  private
  
    
  def set_page_and_order_info_page
    @page       = Page.find_by_page :info
  
    msg         = params[:msg]    
    @info_msg   = (OrderInfoPage.find_by translit: msg).msg
  end  
    
    
  def set_site_title 
    @site_title = MeConstant.find_by_title('site_title').content          
  end                                                 
    
end
