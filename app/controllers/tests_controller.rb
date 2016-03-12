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
      
      if params[:ill_group].to_i > 0 and params[:good_group].to_i > 1
        result = 'Client to good group'
      else
        result = 'Client to ill group'
      end
      
      #flash[:notice] = 'params[:number].to_i: ' + "#{params[:number].to_i}" + ' & Test.find(1).questions.count: ' + "#{Test.find(1).questions.count}"  
      flash[:notice] = 'Test have ended successful. ' + result
      redirect_to '/'
    end  
  end
end
