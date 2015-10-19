class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.string :name
      t.text :description
      t.boolean :able

      t.timestamps null: false
    end
  end
end
