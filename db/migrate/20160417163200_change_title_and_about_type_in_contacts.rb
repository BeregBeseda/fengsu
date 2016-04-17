class ChangeTitleAndAboutTypeInContacts < ActiveRecord::Migration
  def change
    remove_column :contacts,  :about_yourself
    add_column    :contacts,  :about_info,      :text
  end
end
