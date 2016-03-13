# encoding: utf-8
class OrderMailer < ActionMailer::Base

  #default from: "Фен-Шуй консультация"
  default from: 'bereg.beseda@ukr.net'

  
  def a_has_client_payed(order)
    @order = order        
    #@url_name = URI.encode(@order.name)    
    #@form_url = "http://feng-consult.herokuapp.com/i_have_payed/#{@url_name}/#{@order.akey}/#{@order.id}"
    @pay_url = @order.pay_way

    mail(to: @order.email, subject: 'Контакты подходящих Вам людей для построения отношений')    
  end
  
  #def b_confirm_pay_info_to_psyc_for_check(order)
  #  @order = order    
  #  @change_status_to_payed_url = "http://feng-consult.herokuapp.com/payed/#{@order.akey}/#{@order.id}/#{@order.akey_payed}"    
  #  
  #  mail(to: 'bereg.beseda@ukr.net', subject: 'Оплата консультации')        
  #end  
  
  def b_info_to_client_that_pay_data_is_right(order)
    @order = order    
    
    mail(to: @order.email, subject: 'Оплата прошла успешно')
  end
  
end
