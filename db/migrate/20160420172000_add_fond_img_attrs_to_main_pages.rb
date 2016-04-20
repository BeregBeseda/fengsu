class AddFondImgAttrsToMainPages < ActiveRecord::Migration
  def change
    add_column :main_pages, :fond_img_forest_title, :string    
    add_column :main_pages, :fond_img_forest_alt_text, :string    
  end
end
