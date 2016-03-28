class AddTestEndedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :test_ended, :boolean, default: false
  end
end
