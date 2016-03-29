# encoding: utf-8
class OrdersController < ApplicationController

  before_action :set_menu, :set_all_menus,  only: [:a_new_order]
  

  def a_new_order
    @order = Order.new  
  end
  
  def create
    @order = Order.new(order_params)
    @order.akey = akey
    @order.akey_payed = akey  
    @order.able = true
            
    if @order.save
      me_liqpay = MeLiqpay.find_by_me_number(1)
      public_key = me_liqpay.public_key
      private_key = me_liqpay.private_key      
      api_version = me_liqpay.api_version
    
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
    
      def cnb_form_request(params = {}, liqpay, public_key, api_version)
        params[:public_key] = public_key
        json_params = encode64 encode_json params
        signature = liqpay.cnb_signature params            
        @liqpay_url = "https://liqpay.com/api/#{api_version}/checkout?data=#{json_params.to_s}&signature=#{signature.to_s}"
      end
      
      html = cnb_form_request({
        :version        => api_version,
        :action         => 'pay',
        :amount         => "#{@order.sum_for_pay}",
        :currency       => 'UAH',
        :description    => "Оплата теста",
        :server_url     => "http://feng-consult.herokuapp.com/i_have_payed/#{@order.id.to_s.length}#{('a'..'z').to_a.shuffle.first}#{@order.akey}#{@order.id}",
        :result_url     => "http://feng-consult.herokuapp.com/about/-#{flash[:translit] or 'lichnaya-zhizn'}",
        :sandbox        => '1'        
      }, liqpay, public_key, api_version)                                  

      @order.pay_way = @liqpay_url
      @order.save

      OrderMailer.a_has_client_payed(@order, @liqpay_url).deliver    # email to CLIENT: with preparing to test (after pay)
      flash.delete(:order_name)
      flash.delete(:order_email)
      flash.delete(:translit)

      redirect_to html     
       
    else  
      flash[:order_name] = @order.name
      flash[:order_email] = @order.email    
      flash[:translit] = flash[:translit] || 'lichnaya-zhizn'
      flash[:order_errors] = @order.errors
      
      #if cookies are OFF -> show errors in FIRST menu url-case
      @url = '/about/' + 
        if flash[:translit]
          "#{flash[:translit]}"
        else
          'lichnaya-zhizn'
        end        
      redirect_to "#{@url}"
    end  
  end

#*********************************************************************************************************************************************  
  
  
  # client ends the PAY PROCESS [SUCCESSFUL]
  # and want to ENTER TEST (and after - get ACCESS to INFO)
            
  def b_test_for_get_consult_after_pay                
    me_liqpay = MeLiqpay.find_by_me_number(1)
    public_key = me_liqpay.public_key
    private_key = me_liqpay.private_key
        
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
    
    if sign == params[:signature]
      if data_hash["status"].in? ['success', 'sandbox']
        
        details = params[:details]
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
        @test_url = "http://feng-consult.herokuapp.com/test/#{test_url_encoded}"        
 
        @order = Order.find(order_id)      
        @order.payed = true
        @order.pay_way = ''
        @order.when_payed = Time.now.utc
        
        unless @order.sent_email_with_test
          OrderMailer.b_info_to_client_that_pay_data_is_right(@order, @test_url).deliver        
          @order.sent_email_with_test = true
        end  
        
        @order.save        
        
      else
        redirect_to '/'
      end  
    else
      redirect_to '/'  
    end       
  end    
  
  
#*********************************************************************************************************************************************  
    
  
  def order_params
    params.require(:order).permit(:payed, :name, :email, :akey, :pay_way, :sum_for_pay, :when_payed, :akey_payed, :able, :sent_email_with_test, :group_title, :test_ended)
  end  
  
    
  private
  def set_menu
    translit = params[:translit]
    if translit[0] == '-'
      @info_msg = (OrderInfoPage.find_by translit: 'proverte_email_posle_oplaty').msg
      translit[0] = ''
    end
    @menu = Menu.find_by translit: translit  # 1)   get menu-record with title == params[:translit]     // like 'lichnaja-zhizn' etc.
    @menu ||= Menu.first                     # 2)   if record not found -> display the first record  
    flash[:translit] = translit
  end  
    
  def set_all_menus
    @menus = Menu.all
  end                                                 
end    
  
