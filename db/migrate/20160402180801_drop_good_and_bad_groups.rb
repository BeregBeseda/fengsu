class DropGoodAndBadGroups < ActiveRecord::Migration
  def change
    drop_table :good_groups
    drop_table :bad_groups
  end
end
