ActiveAdmin.register BadGroup do
  controller do
    def permitted_params
      params.permit bad_group: [:able_for_contact]
    end
  end
end



      


