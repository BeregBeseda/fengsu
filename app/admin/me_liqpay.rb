ActiveAdmin.register MeLiqpay do
  controller do
    def permitted_params
      params.permit me_liqpay: [:public_key, :private_key, :api_version, :me_number]
    end
  end
end



      


