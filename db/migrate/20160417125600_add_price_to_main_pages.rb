class AddPriceToMainPages < ActiveRecord::Migration
  def change
    add_column :main_pages, :price, :decimal, limit: 5
  end
end
