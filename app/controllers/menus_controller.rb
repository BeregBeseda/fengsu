class MenusController < ApplicationController
  before_action :set_menus, only: [:index]
  
  def index 
  end
  
  
  
  private
  def set_menus
    @menus = Menu.all    
  end          
end
