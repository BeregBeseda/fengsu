class OrderPayIsCheckedController < ApplicationController
    
  def change_status_to_payed
    @order = Order.find(params[:id])
    @order.payed = true
    @order.akey_payed = nil
    
    @order.save
    OrderMailer.c_info_to_client_that_pay_data_is_right(@order).deliver
    redirect_to '/request_sent/2'     
  end 
    
end    
    
