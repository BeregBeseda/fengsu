class CreateGoodGroups < ActiveRecord::Migration
  def change
    create_table :good_groups do |t|
      t.integer :order_id
      t.string :order_email
      t.boolean :able_for_contact, default: true
            
      t.timestamps                
    end
  end
end
