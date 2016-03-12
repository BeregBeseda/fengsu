class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :number_of_question    
      t.string :title
      t.integer :test_id
      t.integer :to_ill_group_point_for_yes
      t.integer :to_ill_group_point_for_no
      t.integer :to_good_group_point_for_yes
      t.integer :to_good_group_point_for_no      
            
      t.timestamps                
    end
  end
end
