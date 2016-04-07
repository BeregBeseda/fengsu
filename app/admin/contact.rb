ActiveAdmin.register Contact do
  controller do
    def permitted_params
      params.permit contact: [:name, :surname, :city, :country, :birthday, :about_yourself, :email, :order_id, :able_for_contact, :group]
    end
  end
end



      


