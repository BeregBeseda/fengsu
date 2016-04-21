# encoding: utf-8
class OrderMailer < ActionMailer::Base

  default from: 'bereg.beseda@gmail.com'
  
  
  def if_contacts_null(order)
    @order = order        
    mail(to: 'bereg.beseda@gmail.com', subject: 'Клиент заплатил и все еще ждет контакты.')    
  end  

end
