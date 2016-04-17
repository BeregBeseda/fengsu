class Pages < ActiveRecord::Migration
  def change
  
    create_table :pages do |t|
      t.string :title_tag
      t.string :description_meta
      t.string :keywords_meta
            
      t.timestamps                      
    end
  end
end
