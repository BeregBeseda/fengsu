class Order < ActiveRecord::Base
  before_save { |order| order.email = order.email.downcase }
  

  validates :name,         presence:       { message:        'please, enter your name' },        
                                             
                           length:         { maximum:        90, 
                                             too_long:       'name is too long' },
                           :on => :create

                           
  validates :email,        presence:       { message:        'wrong email' },      
                                             
                           length:         { maximum:        100, 
                                             too_long:       'email is too long' }, 
                                             
                           format:         { with:           /.+@.+\..+/, 
                                             message:        'please, enter email' },
                           :on => :create                

#*********************************************************************************************************************************************  

  validates :when_payed,   presence:       { message:        'please, enter date and time when you have payed' },        
                                             
                           length:         { maximum:        100, 
                                             too_long:       'when payed line is too long' },
                           :on => :update
                           
  validates :end_cards,    presence:       { message:        'please, enter 2 last digits of card' },        
                                             
                           length:         { maximum:        2, 
                                             too_long:       'too many digits' },   
                                             
                           numericality:   { only_integer:   true, 
                                             message:        'please, enter just digits'  },
                                             
                           :on => :update

end
