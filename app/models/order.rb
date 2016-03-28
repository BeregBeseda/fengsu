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

end
