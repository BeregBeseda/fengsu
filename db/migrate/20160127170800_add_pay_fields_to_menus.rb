class AddPayFieldsToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :price, :string
    add_column :menus, :at_last_price_installed_at, :date
    add_column :menus, :link_for_pay_from_ukr_card_with_price, :string    
    add_column :menus, :at_last_link_for_pay_from_ukr_card_with_price_installed_at, :date    
    add_column :menus, :ukr_pay_link_without_price, :string        
    remove_column :menus, :name
    add_column :menus, :name, :string            
  end
end
