ActiveAdmin.register OrderInfoPage do
  controller do
    def permitted_params
      params.permit order_info_page: [:title, :msg, :translit]
    end
  end
end


