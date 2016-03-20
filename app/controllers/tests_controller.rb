class TestsController < ApplicationController
  def load_page        
    qw_number = params[:qw_number]
    if qw_number.to_i < Test.find(1).questions.count + 1
      question = Test.find(1).questions.find_by_number_of_question(qw_number)
      @question_title = question.title
      
      test_number = "/#{qw_number.to_i + 1}/"
      order_id = params[:order_id]
      order_akey = params[:order_akey]
      
      def qw_point(qw_number)
        case question.for_yes_answer_plus_1_point_to
        when
      end  
      al_no = "/#{params[:al]}" 
      al_yes = al_no.to_i + qw_point('al')
      
      @yes = 'test' + test_number + order_id + order_akey + al_yes.to_s
      @no = 'test' + test_number + order_id + order_akey + al_no
      
      @yes = "/#{params[:].to_i + good_yes}}"
      @no = "/test/#{params[:test_number].to_i + 1}/#{params[:order_id]}/#{params[:order_akey]}/#{params[:]}}"      
      /:al/:nl/:shl/:pl/:gml/:dl/:ml/:ol/:kl/:il/:disl

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
        flash[:notice] = 'There is problem with your ID or Akey. Hm... Maybe you`re hacker, aren`t you?'
      end       
      redirect_to '/'
    end      
    
    
  end
end
