class CreateMeConstants < ActiveRecord::Migration
  def change
    create_table :me_constants do |t|
      t.string :root_path
            
      t.timestamps                
    end
  end
end
