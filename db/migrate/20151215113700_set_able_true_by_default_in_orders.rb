class SetAbleTrueByDefaultInOrders < ActiveRecord::Migration
  def change
    change_column :orders, :able, default: 'true'
  end
end
