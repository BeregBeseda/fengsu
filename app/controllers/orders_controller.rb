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
            
    if @order.save
      ###LIQPAY      
      liqpay = Liqpay::Liqpay.new(
        :public_key  => 'i35395571497',
        :private_key => 'irj04vFv5A7g7pdVVdJ59ja5nh79U5IlylVQk8jQ'
      )    
    
      def encode_json(params)
        JSON.generate(params)
      end    
    
      def encode64(params)
        (Base64.encode64 params).chomp.delete("\n")
      end
    
      def cnb_form_request(params = {}, liqpay)
        params[:public_key] = 'i35395571497'
        json_params = encode64 encode_json params
        signature = liqpay.cnb_signature params            
        @liqpay_url = "https://liqpay.com/api/3/checkout?data=#{json_params.to_s}&signature=#{signature.to_s}"
        #@liqpay_url
      end
      
      html = cnb_form_request({
        :version        => '3',
        :action         => 'pay',
        :amount         => "#{@order.sum_for_pay}",
        :currency       => 'UAH',
        :description    => "Оплата теста",
        #:details        => "#{@order.id.to_s.length}#{('a'..'z')}#{@order.akey}#{@order.id}",
        :server_url     => "http://feng-consult.herokuapp.com/i_have_payed/#{@order.id.to_s.length}#{rand('a'..'z')}#{@order.akey}#{@order.id}",
        :result_url     => "http://feng-consult.herokuapp.com/about/-#{flash[:translit] or 'lichnaya-zhizn'}",
        :sandbox        => '1'        
      }, liqpay)                                  

      @order.pay_way = @liqpay_url
      OrderMailer.a_has_client_payed(@order).deliver    # email to CLIENT: with preparing to test (after pay)
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
    public_key = 'i35395571497'
    private_key = 'irj04vFv5A7g7pdVVdJ59ja5nh79U5IlylVQk8jQ'
        
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
      #if data_hash["status"].in? ['success', 'sandbox']
      if data_hash["status"] == 'success' or data_hash["status"] == 'sandbox' 
        
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
    
        akey = ''
        for i in (order_id_length-1)..(details.length-1-order_id_length)
           akey += details[i]
        end                    
 
        @test_url = "/test/1/#{order_id}/#{order_akey}/0/0/0/0/0/0/0/0/0/0/0"
 
        @order = Order.find(order_id)      
        @order.payed = true
        @order.save
        OrderMailer.b_info_to_client_that_pay_data_is_right(@order, @test_url).deliver        
      else
        redirect_to '/'
      end  
    else
      redirect_to '/'  
    end       
  end    
  
  
#*********************************************************************************************************************************************  
    
  
  def order_params
    params.require(:order).permit(:payed, :name, :email, :akey, :pay_way, :end_cards, :sum_for_pay, :when_payed, :akey_payed, :able)
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
  
