class LetsCreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    
      t.string   :name
      t.string   :surname
      t.string   :city
      t.string   :country
      t.date     :birthday
      t.string   :about_yourself
    
      t.string   :email  
      t.integer  :order_id
      t.boolean  :able_for_contact, default: true
            
      t.timestamps                
    end
  end
end
