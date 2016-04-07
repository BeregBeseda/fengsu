ActiveAdmin.register MeConstant do
  controller do
    def permitted_params
      params.permit me_constant: [:title, :content]
    end
  end
end



      


