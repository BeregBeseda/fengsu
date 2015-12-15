class SetAbleTrueByDefaultInOrders < ActiveRecord::Migration
  def change
    change_column_default :orders, :able, from: false, to: true
  end
end
