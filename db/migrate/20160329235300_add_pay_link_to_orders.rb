class AddPayLinkToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :pay_link, :string
  end
end
