ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "feng-consult.herokuapp.com",  
  :user_name            => "bereg.beseda@gmail.com",  
  :password             => "gsh1978196819971",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}  

ActionMailer::Base.default_url_options = { :host => 'feng-consult.herokuapp.com' }
