class OrdersController < ApplicationController
  before_action :set_menu, only: [:new]

  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    @order.akey = akey
    @order.akey_payed = akey    
    @order.email.downcase!
    @order.able = 'true'
        
    @order.save  
    OrderMailer.confirm_pay(@order).deliver      
    redirect_to '/click_for_pay' 
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update_attributes(order_params)    
    @order.save
    redirect_to '/success_confirm'     
  end  
  
  
  def order_params
    params.require(:order).permit(:payed, :name, :email, :cool_time1, :cool_time2, :akey, :pay_way, :end_cards, :sum_for_pay, :when_payed, :akey_payed, :able)
  end  
  
  
  private
  def set_menu
    @menu = Menu.find_by translit:(params[:translit])   # 1)   get menu-record with title == params[:translit]     // like 'lichnaja-zhizn' etc.
    @menu ||= Menu.first                                # 2)   if record not found -> display the first record  
  end                                                        
end    
  
