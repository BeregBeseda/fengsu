# encoding: utf-8
class OrderMailer < ActionMailer::Base

  default from: 'bereg.beseda@ukr.net'

  
  def a_has_client_payed(order)
    @order = order        
    mail(to: @order.email, subject: 'Контакты подходящих Вам людей для построения отношений')    
  end
    
      
  def b_test_to_client_for_get_contacts_after_cool_pay(order, test_url)
    @order = order            
    @test_url = test_url
    mail(to: @order.email, subject: 'Оплата прошла успешно')
  end
  
end
