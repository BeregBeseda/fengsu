class DropMainPages < ActiveRecord::Migration
  def change
    drop_table :main_pages
  end
end
