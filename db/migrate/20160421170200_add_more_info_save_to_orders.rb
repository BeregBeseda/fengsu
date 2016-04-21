class AddMoreInfoSaveToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :more_info_save, :boolean
  end
end
