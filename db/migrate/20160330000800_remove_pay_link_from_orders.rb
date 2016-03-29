class RemovePayLinkFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :pay_link
  end
end
