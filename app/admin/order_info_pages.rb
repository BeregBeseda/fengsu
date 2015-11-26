ActiveAdmin.register OrderInfoPage do
  controller do
    def permitted_params
      params.permit order_info_page: [:nazva, :msg, :title_translit]
    end
  end
end


