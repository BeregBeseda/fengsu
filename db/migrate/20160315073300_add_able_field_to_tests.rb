class AddAbleFieldToTests < ActiveRecord::Migration
  def change
    add_column :tests, :able, :boolean, default: true
  end
end
