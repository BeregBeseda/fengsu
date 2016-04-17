# encoding: utf-8
class OrderMailer < ActionMailer::Base

  default from: ENV['site_email']

  
  def a_has_client_payed(order)
    @order = order        
    mail(to: @order.email, subject: 'Контакты')    
  end
    
      
  def b_test_to_client_for_get_contacts_after_cool_pay(order, test_url)
    @order = order            
    @test_url = test_url
    mail(to: @order.email, subject: 'Оплата прошла успешно')
  end
  
  
  def c_more_info_form(order, link_with_more_info_form)
    @order = order
    @link_with_more_info_form = link_with_more_info_form
    mail(to: @order.email, subject: 'Информация о себе')
  end
  
  
  def d_see_contacts(order, link_with_contacts)
    @order = order
    @link_with_contacts = link_with_contacts
    mail(to: @order.email, subject: 'Страница с контактами')  
  end
  
      
end
