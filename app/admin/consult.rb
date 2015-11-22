ActiveAdmin.register Consult do
  controller do
    def permitted_params
      params.permit consult: [:title, :description, :price, :at_last_price_installed_at, :link_for_pay_from_ukr_card_with_price, :at_last_link_for_pay_from_ukr_card_with_price_installed_at, :ukr_pay_link_without_price, :able]
    end
  end
end


      


