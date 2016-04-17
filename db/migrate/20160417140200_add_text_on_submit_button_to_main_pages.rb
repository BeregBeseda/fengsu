class AddTextOnSubmitButtonToMainPages < ActiveRecord::Migration
  def change
    add_column :main_pages, :text_on_submit_button, :string
  end
end
