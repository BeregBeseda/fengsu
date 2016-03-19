ActiveAdmin.register Group do
  controller do
    def permitted_params
      params.permit group: [:title]
    end
  end
end



      


