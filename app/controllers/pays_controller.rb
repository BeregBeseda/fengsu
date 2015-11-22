class PaysController < ApplicationController
  def a_for_pay
    @consult = Consult.first
  end
  
  def b_after_pay_form
    @name = params[:name]
    @id = params[:id]
    @akey = params[:akey]
    if Order.where(id: @id).empty? or Order.find(@id).akey != @akey
      redirect_to '/'
    else
      @order = Order.find(@id)
    end  
  end  
  
  def c_success_confirm_form
  end     
end
