ActiveAdmin.register MainPage do
  controller do
    def permitted_params
      params.permit main_page: [:title, :description, :form_name_text, :form_email_text, :count_of_columns, :count_of_left_offsets, :price, :text_on_submit_button, :fond_img_forest_title, :fond_img_forest_alt_text]
    end
  end
end


