class AddOrderIdToBadGroups < ActiveRecord::Migration
  def change
    add_column :bad_groups, :the_order_id, :integer
  end
end
