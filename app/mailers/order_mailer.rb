# encoding: utf-8
class OrderMailer < ActionMailer::Base

  default from: "Фен-Шуй консультация"

  
  def a_has_client_payed(order)
    @order = order    
    @pay_url = "http://psysite.herokuapp.com/click_for_pay"    
    
    @url_name = URI.encode(@order.name)    
    @form_url = "http://psysite.herokuapp.com/i_have_payed/#{@url_name}/#{@order.akey}/#{@order.id}"

    mail(to: @order.email, subject: 'Фен-Шуй консультация')    
  end
  
  def b_confirm_pay_info_to_psyc_for_check(order)
    @order = order    
    @change_status_to_payed_url = "http://psysite.herokuapp.com/payed/#{@order.akey}/#{@order.id}/#{@order.akey_payed}"    
    
    mail(to: 'bereg.beseda@ukr.net', subject: 'Оплата консультации')        
  end  
  
  def c_info_to_client_that_pay_data_is_right(order)
    @order = order    
    
    mail(to: @order.email, subject: 'Оплата прошла успешно')
  end
  
end
