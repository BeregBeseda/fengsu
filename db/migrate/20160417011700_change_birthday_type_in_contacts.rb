class ChangeBirthdayTypeInContacts < ActiveRecord::Migration
  def change
    remove_column :contacts,  :birthday
    add_column    :contacts,  :birthday,       :string
  end
end
