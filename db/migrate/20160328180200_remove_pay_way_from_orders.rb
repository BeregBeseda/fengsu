class RemovePayWayFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :pay_way
  end
end
