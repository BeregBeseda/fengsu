class OrdersController < ApplicationController
  before_action :set_menu, only: [:new]

  def new
  end
  
  
  private
  def set_menu
    @menu = Menu.find_by translit:(params[:translit])
  end  
end
