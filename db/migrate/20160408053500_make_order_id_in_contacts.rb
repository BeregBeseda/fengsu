class MakeOrderIdInContacts < ActiveRecord::Migration
  def change
    remove_column  :contacts,  :order_id
    add_column     :contacts,  :order_number, :integer
  end
end
