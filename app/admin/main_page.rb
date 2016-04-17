ActiveAdmin.register MainPage do
  controller do
    def permitted_params
      params.permit main_page: [:title, :description, :form_name_text, :form_email_text, :count_of_columns, :count_of_left_offsets]
    end
  end
end


