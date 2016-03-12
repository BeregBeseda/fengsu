class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :number_of_test
      t.string :title
            
      t.timestamps                
    end
  end
end
