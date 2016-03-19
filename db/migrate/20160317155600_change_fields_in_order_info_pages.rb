class ChangeFieldsInOrderInfoPages < ActiveRecord::Migration
  def change
    remove_column :order_info_pages, :nazva
    add_column :order_info_pages, :title, :string
    remove_column :order_info_pages, :title_translit
    add_column :order_info_pages, :translit, :string
  end
end
