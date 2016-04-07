class ChangeGroupInOrders < ActiveRecord::Migration
  def change
    remove_column :orders,  :group_title
    add_column    :orders,  :group,       :string
  end
end
