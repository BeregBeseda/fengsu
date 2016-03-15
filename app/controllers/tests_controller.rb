class TestsController < ApplicationController
  def load_page        
    if params[:number].to_i < Test.find(1).questions.count + 1
      question = Test.find(1).questions.find_by_number_of_question(params[:number])
      ill_yes = question.to_ill_group_point_for_yes
      ill_no = question.to_ill_group_point_for_no
      good_yes = question.to_good_group_point_for_yes
      good_no = question.to_good_group_point_for_no
        
      @question_title = question.title
      @yes = "/test/#{params[:number].to_i + 1}/#{params[:ill_group].to_i + ill_yes}/#{params[:good_group].to_i + good_yes}/#{params[:order_id]}/#{params[:order_akey]}"
      @no = "/test/#{params[:number].to_i + 1}/#{params[:ill_group].to_i + ill_no}/#{params[:good_group].to_i + good_no}/#{params[:order_id]}/#{params[:order_akey]}"      

    else
      @order = Order.find(params[:order_id])
      if @order and @order.akey == params[:order_akey]        
        if params[:ill_group].to_i > 0 and params[:good_group].to_i > 1
          result = 'Client has gone to good group'
        else
          result = 'Client has gone to ill group'
        end
        flash[:notice] = 'Test has ended successful. ' + result      
      else
        flash[:notice] = 'There is problem with your ID or Akey. Hm... Maybe you`re hacker?'
      end       
      redirect_to '/'
    end      
    
    
  end
end
