class DropConsults < ActiveRecord::Migration
  def change
    drop_table :consults
  end
end
