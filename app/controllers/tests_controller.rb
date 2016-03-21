class TestsController < ApplicationController
  def load_page        
    qw_number = params[:qw_number].to_i
      al_no = params[:al]
      nl_no = params[:nl]
      shl_no = params[:shl]
      pl_no = params[:pl]
      gml_no = params[:gml]
      dl_no = params[:dl]
      ml_no = params[:ml]
      ol_no = params[:ol]
      kl_no = params[:kl]
      il_no = params[:il]
      disl_no = params[:disl]
      
      order_id = params[:order_id]
      order_akey = params[:order_akey]      
          
    questions = Test.find(1).questions       
    if qw_number.to_i < questions.count + 1
      question = questions.find_by_number_of_question(qw_number)
      @question_title = question.title
      
      next_qw_number = (qw_number + 1).to_s
            
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
      
      @yes_params = {
        :controller => 'tests', 
        :action => 'load_page', 
        :qw_number => next_qw_number,
        :order_id => order_id,
        :order_akey => order_akey,
        :al => "#{al_yes or al_no or '0'}",
        :nl => "#{nl_yes or nl_no or '0'}",
        :shl => "#{shl_yes or shl_no or '0'}",
        :pl => "#{pl_yes or pl_no or '0'}",
        :gml => "#{gml_yes or gml_no or '0'}",
        :dl => "#{dl_yes or dl_no or '0'}",
        :ml => "#{ml_yes or ml_no or '0'}",
        :ol => "#{ol_yes or ol_no or '0'}",
        :kl => "#{kl_yes or kl_no or '0'}",
        :il => "#{il_yes or il_no or '0'}",
        :disl => "#{disl_yes or disl_no or '0'}"
        }
         
      @no_params = {
        :controller => 'tests', 
        :action => 'load_page', 
        :qw_number => next_qw_number,
        :order_id => order_id,
        :order_akey => order_akey,
        :al => "#{al_no or '0'}",
        :nl => "#{nl_no or '0'}",
        :shl => "#{shl_no or '0'}",
        :pl => "#{pl_no or '0'}",
        :gml => "#{gml_no or '0'}",
        :dl => "#{dl_no or '0'}",
        :ml => "#{ml_no or '0'}",
        :ol => "#{ol_no or '0'}",
        :kl => "#{kl_no or '0'}",
        :il => "#{il_no or '0'}",
        :disl => "#{disl_no or '0'}"
        }
                      
    else
          
      ill_group = al_no.to_i + nl_no.to_i + shl_no.to_i + pl_no.to_i + gml_no.to_i
      good_group = dl_no.to_i + ml_no.to_i + ol_no.to_i + kl_no.to_i + il_no.to_i + disl_no.to_i                
      
      @order = Order.find(order_id)
      if @order and @order.akey == order_akey        
      
        if ill_group < 2 or good_group > 1
          result = 'Client has gone to good group'
        else
          result = 'Client has gone to ill group'
        end
        flash[:notice] = 'Test has ended successful. ' + result      
        
      else
        flash[:notice] = 'There is problem with your ID or Akey. Hm: Maybe you`re hacker, aren`t you?'
      end       
      
      redirect_to '/'      
    end              
  end
end
