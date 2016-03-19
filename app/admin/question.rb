ActiveAdmin.register Question do
  controller do
    def permitted_params
      params.permit question: [:title, :test_id, :number_of_question, :for_yes_answer_plus_1_point_to]
    end
  end
end






      


