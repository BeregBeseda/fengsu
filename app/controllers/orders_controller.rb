# encoding: utf-8
class OrdersController < ApplicationController
  
  
  
  def create
    root_path = MeConstant.find_by_title('root_path').content  
    
    @order            = Order.new(order_params)
    @order.akey       = akey
    @order.akey_payed = akey  
    @order.able       = true
#_______________________________________________________________________________


            
    if @order.save
      me_liqpay    = MeLiqpay.find_by_me_number(1)
      public_key   = me_liqpay.public_key
      private_key  = ENV['lp_private_key']
      api_version  = me_liqpay.api_version           
#_______________________________________________________________________________if @order.save


    
      liqpay = Liqpay::Liqpay.new(
        :public_key  => public_key,
        :private_key => private_key
      )    
    
      def encode_json(params)
        JSON.generate(params)
      end    
    
      def encode64(params)
        (Base64.encode64 params).chomp.delete("\n")
      end
#_______________________________________________________________________________if @order.save


    
      def cnb_form_request(params = {}, liqpay, public_key, api_version)
        params[:public_key] = public_key
        json_params = encode64 encode_json params
        signature = liqpay.cnb_signature params            
        @liqpay_url = "https://liqpay.com/api/#{api_version}/checkout?data=#{json_params.to_s}&signature=#{signature.to_s}"
      end
#_______________________________________________________________________________if @order.save



      letter = ('a'..'z').to_a.shuffle.first
      server_url_details  = @order.id.to_s.length.to_s + letter + @order.akey + @order.id.to_s
      
      details_encoded_64  = (Base64.encode64 server_url_details).chomp.delete("\n")
      details_encoded     = details_encoded_64 + '=' 
      server_url_details  = details_encoded
      
      html = cnb_form_request({
        :version          => api_version,
        :action           => 'pay',
        :amount           => @order.sum_for_pay,
        :currency         => 'UAH',
        :description      => "Оплата теста",
        :server_url       => root_path + 'i_have_payed/' + server_url_details,
        :result_url       => root_path + 'info/proverte_email_posle_oplaty',
        :sandbox          => '1'        
      }, liqpay, public_key, api_version)                                  
#_______________________________________________________________________________if @order.save



      @order.pay_link = @liqpay_url
      @order.save

      OrderMailer.a_has_client_payed(@order).deliver       

      #flash.delete(:order_name)
      #flash.delete(:order_email)

      redirect_to html     
#_______________________________________________________________________________if @order.save
       
       
       
    else  
      flash[:order_name]  = @order.name
      flash[:order_email] = @order.email    
      
      
      anchor = ''
      @order.errors.each do |attr, msg|
        flash[:error_class_name]  = 'error_field' if attr == :name
        flash[:error_class_email] = 'error_field' if attr == :email
                
                
        flash[:autofocus_name] = false                
        flash[:autofocus_email] = false     
            
        if attr == :name
          flash[:autofocus_name] = true
        else
          if attr == :email
            flash[:autofocus_email] = true
          end
        end                
                
                
        if attr.in? [:name, :email]
          anchor = '#form'
        end
      end
      
      
      url = root_path +        
            anchor
      redirect_to url 
    end  
  end

#_____________________________________________________________________________________________________________________________________________
  
  
  
  # client ends the PAY PROCESS [SUCCESSFUL]
  # she gets TEST LINK via her email
  # and want to ENTER TEST (and after - get ACCESS to INFO)
            
  def b_test_for_get_contacts_after_pay                
    root_path = MeConstant.find_by_title('root_path').content
    
      
    me_liqpay    = MeLiqpay.find_by_me_number(1)
    public_key   = me_liqpay.public_key
    private_key  = ENV['lp_private_key']
        
    data = params[:data]     
    data_json = Base64.decode64(data)    
    data_hash = JSON.parse(data_json)
    
        
    liqpay = Liqpay::Liqpay.new(
      :public_key  => public_key,
      :private_key => private_key
    )    
    
    sign = liqpay.str_to_sign(
    private_key +
    data +
    private_key
    )       
#_______________________________________________________________________________
  
  
    
    if sign == params[:signature]
      #if data_hash['status'] == 'success'
      if data_hash["status"].in? ['success', 'sandbox']      
        
        
        
        
        details         = params[:details]  
        
        details_encoded = details
        details_encoded[details_encoded.length-1] = ''
        details         = Base64.decode64(details_encoded)    
        
        
        
        order_id_length = ''        
        for i in 0..details.length-1
          unless details[i].in? ('a'..'z')
            order_id_length += "#{details[i]}"  
          else
            break
          end
        end
        order_id_length = order_id_length.to_i
    
        order_id = ''
        for i in (details.length-order_id_length)..(details.length-1)
           order_id += details[i]
        end        
    
        order_akey = ''
        for i in (order_id_length-1)..(details.length-1 - order_id_length)
           order_akey += details[i]
        end                    
        
        
        test_url_hash = {
          :qw_number   => '1',
          :order_id    => "#{order_id}",
          :order_akey  => "#{order_akey}",
          :al          => '0',
          :nl          => '0',
          :shl         => '0',
          :pl          => '0',
          :gml         => '0',
          :dl          => '0',
          :ml          => '0',
          :ol          => '0',
          :kl          => '0',
          :il          => '0',
          :disl        => '0',
        }        

        test_url_json = JSON.generate(test_url_hash)
        test_url_encoded_64 = (Base64.encode64 test_url_json).chomp.delete("\n")
        test_url_encoded = test_url_encoded_64 + '=' 
        test_url = root_path + 'test/' + test_url_encoded        
 
        order = Order.find(order_id)      
        order.payed = true
        order.pay_link = ''
        order.when_payed = Time.now.utc
        
        unless order.sent_email_with_test
          OrderMailer.b_test_to_client_for_get_contacts_after_cool_pay(order, test_url).deliver        
          order.sent_email_with_test = true
        end  
        
        order.save        
#_______________________________________________________________________________
  
  
        
      #else
      #  redirect_to '/'
      end  
    #else
    #  redirect_to '/'  
    end       
  end    
#_____________________________________________________________________________________________________________________________________________    

    
  
  def order_params
    params.require(:order).permit(:payed, :name, :email, :akey, :pay_link, :sum_for_pay, :when_payed, :akey_payed, :able, :sent_email_with_test, :group, :test_ended)
  end  

end    
  
