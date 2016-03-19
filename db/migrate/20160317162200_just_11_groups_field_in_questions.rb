class Just11GroupsFieldInQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :to_ill_group_point_for_yes
    remove_column :questions, :to_ill_group_point_for_no
    remove_column :questions, :to_good_group_point_for_yes
    remove_column :questions, :to_good_group_point_for_no
    add_column :questions, :for_yes_answer_plus_1_point_to, :string
  end
end
