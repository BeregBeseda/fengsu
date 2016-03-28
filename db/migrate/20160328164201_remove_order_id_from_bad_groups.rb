class RemoveOrderIdFromBadGroups < ActiveRecord::Migration
  def change
    remove_column :bad_groups, :order_id
  end
end
