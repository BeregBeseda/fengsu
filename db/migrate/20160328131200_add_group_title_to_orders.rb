class AddGroupTitleToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :group_title, :string
  end
end
