class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :order_id
      t.string :order_email
      t.string :group_title
      t.boolean :able_for_contact, default: true
            
      t.timestamps                
    end
  end
end
