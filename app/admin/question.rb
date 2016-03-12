ActiveAdmin.register Question do
  controller do
    def permitted_params
      params.permit question: [:title, :test_id, :number_of_question, :to_ill_group_point_for_yes, :to_ill_group_point_for_no, :to_good_group_point_for_yes, :to_good_group_point_for_no]
    end
  end
end






      


