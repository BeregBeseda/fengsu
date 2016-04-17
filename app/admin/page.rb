ActiveAdmin.register Page do
  controller do
    def permitted_params
      params.permit page: [:title_tag, :description_meta, :keywords_meta]
    end
  end
end


      


