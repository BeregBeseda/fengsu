class TestsController < ApplicationController
  def load_page        
    qw_number = params[:qw_number].to_i
    if qw_number.to_i < Test.find(1).questions.count + 1
      question = Test.find(1).questions.find_by_number_of_question(qw_number)
      @question_title = question.title
      
      next_qw_number = (qw_number + 1).to_s
      order_id = params[:order_id]
      order_akey = params[:order_akey]
            
      al_yes = ''
      nl_yes = ''
      shl_yes = ''
      pl_yes = ''
      gml_yes = ''
      dl_yes = ''
      ml_yes = ''
      ol_yes = ''
      kl_yes = ''
      il_yes = ''
      disl_yes = ''
                    
      al_no = params[:al]
      nl_no = params[:nl]
      shl_no = params[:shl]
      pl_no = params[:pl]
      gml_no = params[:gml]
      dl_no = params[:l]
      ml_no = params[:ml]
      ol_no = params[:ol]
      kl_no = params[:kl]
      il_no = params[:il]
      disl_no = params[:disl]
            
      case question.for_yes_answer_plus_1_point_to
        when 'al' 
          then al_yes = (al_no.to_i + 1).to_s
        when 'nl' 
          then nl_yes = (nl_no.to_i + 1).to_s
        when 'shl' 
          then shl_yes = (shl_no.to_i + 1).to_s
        when 'pl' 
          then pl_yes = (pl_no.to_i + 1).to_s
        when 'gml' 
          then gml_yes = (gml_no.to_i + 1).to_s
        when 'dl' 
          then dl_yes = (dl_no.to_i + 1).to_s
        when 'ml' 
          then ml_yes = (ml_no.to_i + 1).to_s
        when 'ol' 
          then ol_yes = (ol_no.to_i + 1).to_s
        when 'kl' 
          then kl_yes = (kl_no.to_i + 1).to_s
        when 'il' 
          then il_yes = (il_no.to_i + 1).to_s
        when 'disl' 
          then disl_yes = (disl_no.to_i + 1).to_s
      end
      
      @yes = 'test' + '/' + next_qw_number + '/' + order_id + '/' + order_akey + '/' + al_yes + '/' + nl_yes + '/' + shl_yes + '/' + pl_yes + '/' + gml_yes + '/' + dl_yes + '/' + ml_yes + '/' + ol_yes + '/' + kl_yes + '/' + il_yes + '/' + disl_yes
      @no = 'test' + '/' + next_qw_number + '/' + order_id + '/' + order_akey + '/' + al_no + '/' + nl_no + '/' + shl_no + '/' + pl_no + '/' + gml_no + '/' + dl_no + '/' + ml_no + '/' + ol_no + '/' + kl_no + '/' + il_no + '/' + disl_no      
    else
      
      ### Увага!)
      ### ill_group = sum_values_of_first_5_groups 
      ### good_group = sum_values_last_6_first_groups   
      ###
      ### :->>>
    
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
