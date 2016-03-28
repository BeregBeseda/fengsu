ActiveAdmin.register GoodGroup do
  controller do
    def permitted_params
      params.permit good_group: [:able_for_contact]
    end
  end
end



      


