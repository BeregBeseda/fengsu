ActiveAdmin.register Test do
  controller do
    def permitted_params
      params.permit test: [:title, :number_of_test, :able]
    end
  end
end



      


