class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :payed    
      t.string :name
      t.string :email
      t.string :cool_time1
      t.string :cool_time2
      t.string :akey      
      t.string :pay_way
      t.integer :end_cards      
      t.decimal :sum_for_pay, limit: 5      
      t.string :when_payed 
      t.string :akey_payed                            
      t.boolean :able            
      
      t.timestamps                  
    end
  end
end
