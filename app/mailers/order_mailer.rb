# encoding: utf-8
class OrderMailer < ActionMailer::Base

  default from: "Фен-Шуй консультация"

  
  def confirm_pay(order)
    @order = order    
    @pay_url = "http://psysite.herokuapp.com/click_for_pay"    
    
    @url_name = URI.encode(@order.name)    
    @form_url = "http://psysite.herokuapp.com/confirm_form/#{@url_name}/#{@order.akey}/#{@order.id}"

    mail(to: @order.email, subject: 'Фен-Шуй консультация')    
  end
  
  def confirm_info_for_psyc(order)
    @order = order
    
    mail(to: 'bereg.beseda@ukr.net', subject: 'Оплата консультации')        
  end  
  
end
