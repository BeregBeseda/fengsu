class ContactsController < ApplicationController



  def more_info_form
    @contact = Contact.new
  
    order_info = params[:order_info]
    order_id = ''
    order_akey_payed = ''
    
    for i in 0..order_info.length-1
      unless order_info[i].in? ('a'..'z')
        order_id += "#{order_info[i]}"
      else
        @current_i = i.to_i + 1
        break
      end
    end    
        
    for i in @current_i..order_info.length - 1
      order_akey_payed += "#{order_info[i]}"
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


  
  def create
    contact = Contact.new(contact_params) 
    root_path = MeConstant.find_by_title('root_path').content
    
    if contact.save        

    order = Order.find(contact.order_number)    
    if order 
    
      contacts_status = if order.group == 'GOOD GROUP'                     
        [1,3,5,7,9].shuffle.first.to_s
      else
        [2,4,6,8].shuffle.first.to_s      
      end

      plus_2_letters      = ('a'..'z').to_a.shuffle.first + 
                            ('a'..'z').to_a.shuffle.first
           
      contacts_details    = contacts_status               + 
                            order.id.to_s                 + 
                            plus_2_letters                + 
                            order.akey_payed                     

      @link_with_contacts = root_path                     + 
                            'contacts/'                   + 
                            contacts_details                      



      #OrderMailer.d_see_contacts(order, @link_with_contacts).deliver      !!!!!      
      redirect_to @link_with_contacts                         

    else
      flash[:notice]   = 'There is problem with your ID or Akey. Hm: Maybe you`re hacker, aren`t you?'
      redirect_to '/'
    end       
    
  else
    flash[:notice] = 'can`t save'
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
      Contact.where(group: 'GOOD GROUP').where.not(order_number: order_id)
    else  
      Contact.where(group: 'BAD GROUP' ).where.not(order_number: order_id)
    end        
  end
#_____________________________________________________________________________________________________________________________________________



  def contact_params
    params.require(:contact).permit(:name, :surname, :city, :country, :birthday, :about_yourself, :email, :order_number, :able_for_contact, :group)
  end  

  
end
