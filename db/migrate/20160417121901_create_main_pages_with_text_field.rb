class CreateMainPagesWithTextField < ActiveRecord::Migration
  def change
  
    create_table :main_pages do |t|
      t.string :title
      t.text   :description
      t.string :form_name_text
      t.string :form_email_text
      t.string :count_of_columns
      t.string :count_of_left_offsets
            
      t.timestamps                      
    end
  end
end
