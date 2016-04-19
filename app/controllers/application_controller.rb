# encoding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  helper_method :akey
  
      
  def akey
    key_int = 10.times.map{rand(1..99)}
    key_str = 10.times.map{('a'..'z').to_a[rand(26)]}
    key_int.concat(key_str)
    key_int.shuffle!
    key_int.shuffle!    
    key_int.join  
  end   

  
end
