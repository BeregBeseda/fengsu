class ContactsController < ApplicationController

  before_action :set_order,  only: [:more_info_form]
#_____________________________________________________________________________________________________________________________________________    
  
  

  def more_info_form
    order_info = params[:order_info]
    order_id = ''
    order_akey_payed = ''
    
    for i in 0..order_info.length-1
      unless details[i].in? ('a'..'z')
        order_id += "#{details[i]}"
      else
        @current_i = i.to_i + 1
        break
      end
    end    
        
    for i in @current_i..order_info.length - 1
      order_akey_payed += "#{details[i]}"
    end        
#_______________________________________________________________________________        
        


    order = Order.find(order_id)    
    if order and order.akey_payed == order_akey_payed            
      @order = order
    else
      flash[:notice]   = 'There is problem with your ID or Akey. Hm: Maybe you`re hacker, aren`t you?'
      redirect_to '/'
    end       

  end
#_____________________________________________________________________________________________________________________________________________


  
  def save_more_info
    contact = Contact.new(contact_params) 
    if contact.save
    
    root_path = MeConstant.find_by_title('root_path')

    order = Order.find(contact.order_id)    
    if order 
    
        if order.group == 'GOOD GROUP'        
        
          contacts_status     = [1,3,5,7,9].shuffle.first
          plus_2_letters      = ('a'..'z').to_a.shuffle.first + 
                                ('a'..'z').to_a.shuffle.first
                                
          contacts_details    = contacts_status               +
                                plus_2_letters                + 
                                order.id.to_s                 + 
                                order.akey_payed          
                                
          @link_with_contacts = root_path                     +
                                'contacts/'                   +
                                contacts_details                      
        end
#_______________________________________________________________________________



        if order.group == 'BAD GROUP'
                
          contacts_status     = [2,4,6,8].shuffle.first
          plus_2_letters      = ('a'..'z').to_a.shuffle.first + 
                                ('a'..'z').to_a.shuffle.first
                
                                
          contacts_details    = contacts_status               +
                                plus_2_letters                + 
                                order.id.to_s                 + 
                                order.akey_payed          
                                
          @link_with_contacts = root_path                     +
                                'contacts/'                   +
                                contacts_details                      
        end
#_______________________________________________________________________________



      #OrderMailer.d_see_contacts(order, @link_with_contacts).deliver      !!!!!      
      redirect_to "#{@link_with_contacts}"                         

    else
      flash[:notice]   = 'There is problem with your ID or Akey. Hm: Maybe you`re hacker, aren`t you?'
      redirect_to '/'
    end       

  end

  end
#_____________________________________________________________________________________________________________________________________________



  def show
    details = params[:details]
    #details = 1#{order.id}#{('a'..'z').to_a.shuffle.first}#{('a'..'z').to_a.shuffle.first}#{order.akey_payed}
    status  = details[0]
   
    order_id   = ''
    akey_payed = ''
    
    for i in 1..details.length-1
      unless details[i].in? ('a'..'z')
        order_id  += details[i].to_s
      else
        akey_start = i.to_i + 2
        break
      end
    end
#_______________________________________________________________________________


    
    for i in ( akey_start..details.length - 1 )
      akey_payed += details[i].to_s
    end     
    
    @order = Order.find(order_id)   
    unless ( @order and @order.akey_payed == akey_payed )
      redirect_to '/'  
    end               
    
    @contacts = if ( status % 2 == 0 )
      Contact.find_all_by_group('GOOD GROUP' ).where.not(order_id: order_id)
    else  
      Contact.find_all_by_group( 'BAD GROUP' ).where.not(order_id: order_id)
    end        
  end
#_____________________________________________________________________________________________________________________________________________



  def contact_params
    params.require(:contact).permit(:name, :surname, :city, :country, :birthday, :about_yourself, :email, :order_id, :able_for_contact, :group)
  end  
#_____________________________________________________________________________________________________________________________________________
  


  private
    
  def set_menu
    @order = Order.find(params[:order_id])    
  end
  
end
