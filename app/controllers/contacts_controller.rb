class ContactsController < ApplicationController



  def more_info_form
    @page       = Page.find_by_page :more_info_form
  
    @site_title = MeConstant.find_by_title('site_title').content
  
    @contact = Contact.new


  
    order_info  = params[:order_info]
           
    order_info[order_info.length-1] = ''
    order_info  = Base64.decode64(order_info)        



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
      #Mail to Admin
      redirect_to '/'
    end       

  end
#_____________________________________________________________________________________________________________________________________________


  
  def create
    contact    = Contact.new(contact_params) 
    root_path  = MeConstant.find_by_title('root_path').content

    order      = Order.find(contact.order_number)    
    
    if order
    
        
    if contact.save        

    
      contacts_status = if order.group == 'GOOD GROUP'                     
        [2,4,6,8].shuffle.first.to_s
      else
        [1,3,5,7,9].shuffle.first.to_s      
      end

      plus_2_letters      = ('a'..'z').to_a.shuffle.first + 
                            ('a'..'z').to_a.shuffle.first
           
      contacts_details    = contacts_status               + 
                            order.id.to_s                 + 
                            plus_2_letters                + 
                            order.akey_payed                     



      contacts_details_encoded_64  = (Base64.encode64 contacts_details).chomp.delete("\n")
      contacts_details     = contacts_details_encoded_64 + '='



      link_with_contacts = root_path                      + 
                           'contacts/'                    + 
                           contacts_details                      



      OrderMailer.d_see_contacts(order, link_with_contacts).deliver      
      redirect_to link_with_contacts                         
          
    else
    


      flash[:contact_name]            = contact.name
      flash[:contact_surname]         = contact.surname
      flash[:contact_city]            = contact.city
      flash[:contact_country]         = contact.country
      flash[:contact_birthday]        = contact.birthday
      flash[:contact_about_info]      = contact.about_info
      
      
      
      anchor = ''
      contact.errors.each do |attr, msg|
        flash[:error_class_name]            = 'error_field' if attr == :name
        flash[:error_class_surname]         = 'error_field' if attr == :surname
        flash[:error_class_city]            = 'error_field' if attr == :city
        flash[:error_class_country]         = 'error_field' if attr == :country
        flash[:error_class_birthday]        = 'error_field' if attr == :birthday
        flash[:error_class_about_info]      = 'error_field' if attr == :about_info
                
                
                
        flash[:autofocus_name]      = false                
        flash[:autofocus_surname]   = false         
        flash[:autofocus_city]      = false                
        flash[:autofocus_country]   = false         
        flash[:autofocus_birthday]  = false                
        flash[:about_info]      = false         
        
                        
                        
        if attr == :name
          flash[:autofocus_name] = true
        else
        
          if attr == :surname
            flash[:autofocus_surname] = true
          else
          
            if attr == :city
              flash[:autofocus_city] = true
            else
          
              if attr == :country
                flash[:autofocus_country] = true
              else
          
                if attr == :birthday
                  flash[:autofocus_birthday] = true
                else
          
                  if attr == :about_info
                    flash[:autofocus_about_info] = true
                  end                        
                end                        
              end            
            end            
          end
        end     

        
                
        if attr == :name
          anchor = 'name'
        else  
        
          if attr == :surname
            anchor = 'surname'
          else  
          
            if attr == :city
              anchor = 'city'
            else  
            
              if attr == :country
                anchor = 'country'
              else  
              
                if attr == :birthday
                  anchor = 'birthday'
                else  
                
                  if attr == :about_info
                    anchor = 'about_info'
                  else  
                  end                                            
                end                                        
              end                        
            end                    
          end                  
        end
        
      end    
      
           
           
      letter                    = ('a'..'z').to_a.shuffle.first
      
      url_with_contacts_details = order.id.to_s      +
                                  letter             +        
                                  order.akey_payed   +
                                  '#'                +
                                  anchor
                                                                                                      
      url_with_contacts_details_encoded_64  = (Base64.encode64 url_with_contacts_details).chomp.delete("\n")
      url_with_contacts_details = url_with_contacts_details_encoded_64 + '=' 
      
      
      
      url_with_contacts         = root_path           +
                                 'much_form/'         + 
                                  url_with_contacts_details
                                               
             
      redirect_to url_with_contacts         
  end
    else
      flash[:notice]   = 'There is problem with your ID or Akey. Hm: Maybe you`re hacker, aren`t you?'
      redirect_to '/'
    end       
  end
#_____________________________________________________________________________________________________________________________________________



  def show
    @page            = Page.find_by_page :contacts
  
  
  
    details_encoded  = params[:details]
    
    details_encoded[details_encoded.length-1] = ''
    details          = Base64.decode64(details_encoded)    
    
    
    
    
    status     = details[0].to_i
   
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
    
    order = Order.find(order_id)   
    unless ( order and order.akey_payed == akey_payed )
      redirect_to '/'  
    end               
    
    @contacts = if ( status % 2 == 0 )
      Contact.where( group: 'GOOD GROUP')
    else  
      Contact.where( group: 'BAD GROUP' )
    end        
    
    @contacts = @contacts.where.not(order_number: order_id)
  end
#_____________________________________________________________________________________________________________________________________________



  def contact_params
    params.require(:contact).permit(:name, :surname, :city, :country, :birthday, :about_info, :email, :order_number, :able_for_contact, :group)
  end  

  
end
