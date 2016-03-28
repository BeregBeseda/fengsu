class AddOrderIdToGoodGroups < ActiveRecord::Migration
  def change
    add_column :good_groups, :the_order_id, :integer
  end
end
