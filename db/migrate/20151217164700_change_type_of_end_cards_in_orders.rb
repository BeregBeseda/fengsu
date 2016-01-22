class ChangeTypeOfEndCardsInOrders < ActiveRecord::Migration
  def change
    change_column :orders, :end_cards, :string
  end
end
