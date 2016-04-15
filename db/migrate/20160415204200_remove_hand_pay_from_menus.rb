class RemoveHandPayFromMenus < ActiveRecord::Migration
  def change
    remove_column :menus, :at_last_price_installed_at
    remove_column :menus, :link_for_pay_from_ukr_card_with_price
    remove_column :menus, :at_last_link_for_pay_from_ukr_card_with_price_installed_at
    remove_column :menus, :ukr_pay_link_without_price    
  end
end
