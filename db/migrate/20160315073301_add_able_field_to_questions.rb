class AddAbleFieldToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :able, :boolean, default: true
  end
end
