class RemoveOrderIdFromGoodGroups < ActiveRecord::Migration
  def change
    remove_column :good_groups, :order_id
  end
end
