class RemoveOldHandColumnsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :cool_time1
    remove_column :orders, :cool_time2
    remove_column :orders, :end_cards            
  end
end
