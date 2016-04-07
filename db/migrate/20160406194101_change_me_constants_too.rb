class ChangeMeConstantsToo < ActiveRecord::Migration
  def change
    remove_column :me_constants,  :contant
    add_column    :me_constants,  :content,   :string    
  end
end
