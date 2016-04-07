class ChangeMeConstants < ActiveRecord::Migration
  def change
    remove_column :me_constants,  :root_path
    add_column    :me_constants,  :title,     :string
    add_column    :me_constants,  :contant,   :string    
  end
end
