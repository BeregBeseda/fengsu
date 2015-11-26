class PaysController < ApplicationController

  def b_page_for_select_pay_way # client come from email & start PAY PROCESS  
    @consult = Consult.first  # payment gateway gets ACTUAL PRICE
    
  end #   when client ends the PAY PROCESS, 
      #   she goes from her email to form_for_get_consult_after_pay 
      #>> to ask for CONSULTATION BODY    
end
