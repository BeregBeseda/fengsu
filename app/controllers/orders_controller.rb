# encoding: utf-8

#require 'base64'
#require 'json'


class OrdersController < ApplicationController

  before_action :set_menu, :set_all_menus,  only: [:a_new_order]
  before_action :set_order, only: [:update, :change_status_to_payed]

  def a_new_order
    @order = Order.new  
  end
  
  def create
    @order = Order.new(order_params)
    @order.akey = akey
    @order.akey_payed = akey  
            
    if @order.save
      OrderMailer.a_has_client_payed(@order).deliver    # email to CLIENT: with form_for_get_consult_after_pay & page_for_select_pay_way           
      flash.delete(:order_name)
      flash.delete(:order_email)
      flash.delete(:translit)
      #redirect_to '/click_for_pay'                      # redirect to payment GATEWAY
      
      ###LIQPAY      
      liqpay = Liqpay::Liqpay.new(
        :public_key  => ::Liqpay.config.public_key,
        :private_key => ::Liqpay.config.private_key
      )
      
      #def encode_json(params)
      #  JSON.generate(params)
      #end    
      
      #def encode64(param)
      #  (Base64.encode64 params).chomp.delete("\n")
      #end
      
      def cnb_form_request(params = {})
        fail "Version can't be empty" if params[:version].nil? or params[:version].empty?
        language = 'ru'
        language = params[:language] unless params[:language].nil?
        params[:public_key] = ::Liqpay.config.public_key       
      #  json_params = encode64 encode_json params
      #  signature = liqpay.cnb_signature params
            
      #  "https://liqpay.com/api/3/checkout?data=#{json_params.to_s}&signature=#{signature.to_s}"
      end
      
      html = cnb_form_request({
        :version        => '3',
        :action         => "pay",
        :amount         => "#{@order.sum_for_pay}",
        :currency       => "UAH",
        :description    => "description text",
        :details        => "#{@order.id.to_s.length}#{('a'..'z')}#{@order.akey}#{@order.id}",
        :server_url     => "http://feng-consult.herokuapp.com/",
        :result_url     => "http://feng-consult.herokuapp.com/i_have_payed",
        :sandbox        => "1"        
      })                              

      #redirect_to html
      redirect_to '/'
      
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
  # and want to get email with ACCESS INFO
            
  def c_form_for_get_consult_after_pay                # for ENTER payment data (2 last DIGITS of credit card & PAYMENT DATE) 
    data = params[:data]
    signature = params[:signature]
    
      liqpay = Liqpay::Liqpay.new(
        :public_key  => ::Liqpay.config.public_key,
        :private_key => ::Liqpay.config.private_key
      )   

    sign = liqpay.str_to_sign(
      ::Liqpay.config.private_key + 
      data +
      ::Liqpay.config.private_key
    )
    
    details = sign[:details]
    order_id_length = ''
    for i in 0..@details.length-1
      if (0..9).include?(details[i])
        order_id_length += details[i]
      else
        break
      end
    end
    
    akey = ''
    #for i in ((@details.length-1)-order_id_length.to_i)..(@details.length-1)
    for i in order_id_length.length..(((@details.length-1)-order_id_length.to_i)-1)
       akey += @details[i]
    end    
    
    order_id = ''
    for i in ((@details.length-1)-order_id_length.to_i)..(@details.length-1)
       order_id += @details[i]
    end
    
    
    
    #@name = params[:name]
    #@id = params[:id]
    #@akey = params[:akey]
    
    unless details[:status] == 'sandbox'
      redirect_to '/'
    end
    
    if Order.where(id: order_id).empty? or Order.find(order_id).akey != akey
      redirect_to '/about/lichnaya-zhizn'
    else
      @order = Order.find(order_id)
    end  
  end    
  
  def update
    @order.update_attributes(order_params)    
    
    if @order.save
      OrderMailer.b_confirm_pay_info_to_psyc_for_check(@order).deliver    
      flash.delete(:order_name)
      flash.delete(:order_email)
      flash.delete(:translit)    
      redirect_to '/request_sent/1'
    else
      flash[:order_when_payed] = @order.when_payed
      flash[:order_end_cards] = @order.end_cards
      flash[:order_errors] = @order.errors
      
      redirect_to "/i_have_payed/#{@order.name}/#{@order.akey}/#{@order.id}"
    end
  end
   
  def d_pay_info_success_sent
    @order_info_page = OrderInfoPage.find(params[:id])
  end
#*********************************************************************************************************************************************  

    
  def change_status_to_payed    
    @order.payed = true
    @order.akey_payed = nil
    
    @order.save
    OrderMailer.c_info_to_client_that_pay_data_is_right(@order).deliver
    redirect_to '/request_sent/2'     
  end 
#*********************************************************************************************************************************************  
    
  
  def order_params
    params.require(:order).permit(:payed, :name, :email, :akey, :end_cards, :sum_for_pay, :when_payed, :akey_payed, :able)
  end  
  
    
  private
  def set_menu
    @menu = Menu.find_by translit:(params[:translit])   # 1)   get menu-record with title == params[:translit]     // like 'lichnaja-zhizn' etc.
    @menu ||= Menu.first                                # 2)   if record not found -> display the first record  
    flash[:translit] = params[:translit]
  end  
    
  def set_all_menus
    @menus = Menu.all
  end    
  
  def set_order
    @order = Order.find(params[:id])
  end                                                      
end    
  
