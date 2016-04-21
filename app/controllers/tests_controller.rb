require 'rsa'
require 'uri'
class TestsController < ApplicationController

  before_action :set_main_page, only: [:load_page]
#_____________________________________________________________________________________________________________________________________________

  
  
  def load_page 
    @page       = Page.find_by_page :test
  
    @site_title = MeConstant.find_by_title('site_title').content
      
    root_path = MeConstant.find_by_title('root_path').content
     
    test_url_encoded = params[:test_url_encoded]
    test_url_encoded[test_url_encoded.length-1] = ''
    test_url_json    = Base64.decode64(test_url_encoded)    
    test_url_hash    = JSON.parse(test_url_json)    
    
    qw_number  = test_url_hash["qw_number"].to_i
    order_id   = test_url_hash["order_id"]
    order_akey = test_url_hash["order_akey"]
    
    al_no   = test_url_hash["al"]
    nl_no   = test_url_hash["nl"]
    shl_no  = test_url_hash["shl"]
    pl_no   = test_url_hash["pl"]
    gml_no  = test_url_hash["gml"]
    dl_no   = test_url_hash["dl"]
    ml_no   = test_url_hash["ml"]
    ol_no   = test_url_hash["ol"]
    kl_no   = test_url_hash["kl"]
    il_no   = test_url_hash["il"]
    disl_no = test_url_hash["disl"]
#_______________________________________________________________________________        
          
          
          
    questions = Test.find(1).questions       
    if qw_number < questions.count + 1
    
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
      
      yes_params_hash = {
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
        
        yes_params_json = JSON.generate(yes_params_hash)
        yes_params_encoded_64 = (Base64.encode64 yes_params_json).chomp.delete("\n")
        yes_params_encoded = yes_params_encoded_64 + '='
        @yes_params = root_path + "test/#{yes_params_encoded}"
#_______________________________________________________________________________
                
         
         
      no_params_hash = {
        :controller  => 'tests', 
        :action      => 'load_page', 
        :qw_number   => next_qw_number,
        :order_id    => order_id,
        :order_akey  => order_akey,
        :al          => "#{al_no or '0'}",
        :nl          => "#{nl_no or '0'}",
        :shl         => "#{shl_no or '0'}",
        :pl          => "#{pl_no or '0'}",
        :gml         => "#{gml_no or '0'}",
        :dl          => "#{dl_no or '0'}",
        :ml          => "#{ml_no or '0'}",
        :ol          => "#{ol_no or '0'}",
        :kl          => "#{kl_no or '0'}",
        :il          => "#{il_no or '0'}",
        :disl        => "#{disl_no or '0'}"
        }
        
        no_params_json = JSON.generate(no_params_hash)
        no_params_encoded_64 = (Base64.encode64 no_params_json).chomp.delete("\n")
        no_params_encoded = no_params_encoded_64 + '='
        @no_params = root_path + "test/#{no_params_encoded}"
        
                                      
    else
#_______________________________________________________________________________
          
          
          
      bad_group  = al_no.to_i   + 
                   nl_no.to_i   + 
                   shl_no.to_i  +  
                   gml_no.to_i
                   
      good_group = dl_no.to_i   + 
                   ml_no.to_i   + 
                   ol_no.to_i   + 
                   pl_no.to_i   + 
                   kl_no.to_i   + 
                   il_no.to_i   + 
                   disl_no.to_i                

      order = Order.find(order_id)            
#_______________________________________________________________________________



      if order and order.akey == order_akey                
        
                
        if bad_group < 2 or good_group > 1
        
          order.group         = 'GOOD GROUP'           
          flash[:notice]      = 'Client has gone to good group'

        else         
          
          order.group         = 'BAD GROUP'                   
          flash[:notice]      = 'Client has gone to bad group'
          
        end
#_______________________________________________________________________________
            
            
                                           
        order.test_ended = true
        order.akey       = ''
        order.save         
#_______________________________________________________________________________
        
        
        
      else
        #Mail to Admin
        redirect_to '/'
      end       
#_______________________________________________________________________________
      
      
      
      redirect_letter          = ('a'..'z').to_a.shuffle.first
      link_details             = order.id.to_s + redirect_letter + order.akey_payed
#_______________________________________________________________________________


      
      link_details_encoded_64  = (Base64.encode64 link_details).chomp.delete("\n")
      link_details_encoded     = link_details_encoded_64 + '=' 
#_______________________________________________________________________________


            
      #key_pair  = RSA::KeyPair.generate(1024)
      #link_details_begin_ascii_8 = key_pair.encrypt(link_details_encoded)
      #link_details_begin_for_url = URI.encode(link_details_begin_ascii_8)         
      
            
      
      #link_details_begin_ascii_8 = key_pair.encrypt(link_details_encoded)      
      
      
      
      #link_details_begin = link_details_begin_for_url 
      
      
      #link_with_more_info_form = root_path + 'much_form/' + link_details_begin
      link_with_more_info_form = root_path + 'much_form/' + link_details_encoded       
#_______________________________________________________________________________      
      
      
      
      OrderMailer.c_more_info_form(order, link_with_more_info_form).deliver                  
      redirect_to link_with_more_info_form
    end              
  end
#_______________________________________________________________________________      

  
  
  private
  
    def set_main_page
      @main_page  = MainPage.find(1)       
    end    
  
  
end
