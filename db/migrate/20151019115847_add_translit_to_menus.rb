class AddTranslitToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :translit, :string
  end
end
