class PaysController < ApplicationController
  def page_for_select_pay_way
    @consult = Consult.first  # get actual price
  end    
end
