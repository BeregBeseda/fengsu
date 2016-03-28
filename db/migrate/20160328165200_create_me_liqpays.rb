class CreateMeLiqpays < ActiveRecord::Migration
  def change
    create_table :me_liqpays do |t|
      t.integer :me_number
      t.string :public_key
      t.string :private_key
      t.string :api_version
            
      t.timestamps                
    end
  end
end
