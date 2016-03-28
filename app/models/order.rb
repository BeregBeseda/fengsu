class Order < ActiveRecord::Base
  belongs_to :good_group
  belongs_to :bad_group  

  before_save { |order| order.email = order.email.downcase }
  


  validates :name,         presence:       { message:       'please, enter your name' },        
                                             
                           length:         { maximum:        100, 
                                             too_long:      'name is too long',
                                             :if => :name? },
                           :on => :create

                           
  validates :email,        presence:       { message:       'please, enter email' },      
                                             
                           length:         { maximum:        100, 
                                             too_long:      'email is too long',
                                             :if => :email? }, 
                                             
                           format:         { with:           /.+@.+\..+/, 
                                             message:       'wrong email',
                                             :if => :email? },
                                             
                           :on => :create                

#*********************************************************************************************************************************************  

  validates :when_payed,   presence:       { message:       'please, enter date and time when you have payed' },        
                                             
                           length:         { maximum:        100, 
                                             too_long:      'when payed line is too long',
                                             :if =>          :when_payed? },
                           :on => :update
                           
  validates :end_cards,    presence:       { message:       'please, enter 2 last digits of card' },        
                                             
                           numericality:   { only_integer:   true,
                                             message:        'is not a number ' },                  
                                             
                           length:         { is:             2, 
                                             wrong_length:  'wrong length',                                             
                                             :if =>         :end_cards? },   
                                             
                           :on => :update

end
