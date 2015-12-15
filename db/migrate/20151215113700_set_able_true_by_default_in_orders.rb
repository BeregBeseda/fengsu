class SetAbleTrueByDefaultInOrders < ActiveRecord::Migration
  def change
    change_column :orders, :able, :boolean, default: 'true'
  end
end
