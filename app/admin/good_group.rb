ActiveAdmin.register GoodGroup do
  controller do
    def permitted_params
      params.permit good_group: [:the_order_id, :order_email, :able_for_contact]
    end
  end
end



      


