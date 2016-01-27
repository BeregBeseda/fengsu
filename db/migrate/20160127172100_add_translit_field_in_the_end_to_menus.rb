class AddTranslitFieldInTheEndToMenus < ActiveRecord::Migration
  def change
    remove_column :menus, :translit
    add_column :menus, :translit, :string            
  end
end
