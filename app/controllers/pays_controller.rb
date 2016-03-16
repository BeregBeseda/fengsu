class PaysController < ApplicationController

  def please_visit_your_email # client come from email & start PAY PROCESS  
    @consult = Consult.first  # payment gateway gets ACTUAL PRICE
    
  end #   when client ends the PAY PROCESS, 
      #   she goes from her email to form_for_get_consult_after_pay 
      #>> to ask for CONSULTATION BODY    
end
