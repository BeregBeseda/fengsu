class CreateConsults < ActiveRecord::Migration
  def change
    create_table :consults do |t|
      t.string :title
      t.text :description
      t.decimal :price, limit: 5
      t.date :at_last_price_installed_at                  
      t.string :link_for_pay_from_ukr_card_with_price
      t.date :at_last_link_for_pay_from_ukr_card_with_price_installed_at           
      t.string :ukr_pay_link_without_price      
      t.boolean :able
      
      t.timestamps                
    end
  end
end
