class ContactsController < ApplicationController

  def show
    details = params[:details]
    #details = 1#{order.id}#{('a'..'z').to_a.shuffle.first}#{('a'..'z').to_a.shuffle.first}#{order.akey_payed}
    @status = details[0]
   
    order_id   = ''
    akey_payed = ''
    
    for i in 1..details.length-1
      unless details[i].in? ('a'..'z')
        order_id += "#{details[i]}"
      else
        @akey_start = i.to_i + 2
        break
      end
    end
    
    for i in @akey_start..details.length-1
      akey_payed += "#{details[i]}"
    end     
    
    @order = Order.find(order_id)   
    unless @order and @order.akey_payed == akey_payed
      redirect_to '/'  
    end               
    
    if status % 2 == 0
      #@orders = 
    end
        
  end

end
