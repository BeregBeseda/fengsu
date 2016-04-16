class MenusController < ApplicationController
  before_action :set_menus, only: [:index]
  
  def index 
    root_path = MeConstant.find_by_title('root_path').content  
    @prerender_page = root_path + 'about/lichnaya-zhizn'
  end
  
  
  private
  def set_menus
    @menus = Menu.all    
  end          
end
