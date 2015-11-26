class CreateOrderInfoPages < ActiveRecord::Migration
  def change
    create_table :order_info_pages do |t|
      t.string :nazva
      t.text :msg
      t.string :title_translit

      t.timestamps null: false
    end
  end
end
