class AddTestEmailToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :sent_email_with_test, :boolean, default: false
  end
end
