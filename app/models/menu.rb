class Menu < ActiveRecord::Base
  before_save :translit_menu_title
  
  private
  def translit_menu_title
    res = self.title.clone.to_s
    5.times do   
    for counter in 0..res.length 
      case res[counter]
      when 'а', 'А'
        res[counter] = 'a'
      when 'б', 'Б'
        res[counter] = 'b'
      when 'в', 'В'
        res[counter] = 'v'  
      when 'г', 'Г', 'Ґ', 'ґ'
        res[counter] = 'g'  
      when 'д', 'Д'
        res[counter] = 'd'  
      when 'е', 'Е', 'ё', 'Є', 'є', 'Э', 'э'
        res[counter] = 'e' 
      when 'ж', 'Ж'
        res[counter] = 'zh'  
      when 'з', 'З'
        res[counter] = 'z'  
      when 'и', 'И'
        res[counter] = 'i'  
      when 'й', 'Й'
        res[counter] = 'y'  
      when 'к', 'К'
        res[counter] = 'k'
      when 'л', 'Л'
        res[counter] = 'l'                       
      when 'м', 'М'
        res[counter] = 'm'                       
      when 'н', 'Н'
        res[counter] = 'n'                       
      when 'о', 'О'
        res[counter] = 'o'                       
      when 'п', 'П'
        res[counter] = 'p'                       
      when 'р', 'Р'
        res[counter] = 'r'                       
      when 'с', 'С'
        res[counter] = 's'                       
      when 'т', 'Т'
        res[counter] = 't'                       
      when 'у', 'У'
        res[counter] = 'u'                                                                        
      when 'ф', 'Ф'
        res[counter] = 'f'                                                                
      when 'х', 'Х'
        res[counter] = 'h'                                                                    
      when 'ц', 'Ц'
        res[counter] = 'ts'                                                                
      when 'ч', 'Ч'
        res[counter] = 'ch'                                                                
      when 'ш', 'Ш'
        res[counter] = 'sh'                                                                      
      when 'щ', 'Щ'
        res[counter] = 'shch'                                                                
      when 'ь', 'ъ', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '"', "'", '[', ']', '{', '}', "\\", '|', '`', '~', '№', ';', '.', ','
        res[counter] = ''
      when 'ы', 'Ы'
        res[counter] = 'y'
      when 'ю', 'Ю'
        res[counter] = 'yu'
      when 'Я', 'я'
        res[counter] = 'ya'
      when 'ї', 'Ї'
        res[counter] = 'yi'                                                  
      when '.', ',', ' ', '_'
        res[counter] = '-'  
      end      

      for counter in 0..res.length 
        case res[counter]
        when ' ' 
          res[counter] = '-'
        when '.', ',', ' ', '_', 'ь', 'ъ', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '"', "'", '[', ']', '{', '}', "\\", '|', '`', '~', '№', ';', '.', ',' 
          res[counter] = ''
      end
      
      res[res.length-1] = '' if res[res.length-1] == '-'        
    end          
      #minus_qual = 0      
      #if res[counter] == '-'
      #  minus_qual = minus_qual+1
      #end
      #if minus_qual > 1
      #  res[counter] = ''
      #  minus_qual = 0
      #end      
    end
    end
    self.translit = res
  end 
     
  
end
