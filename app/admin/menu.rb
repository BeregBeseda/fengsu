ActiveAdmin.register Menu do
  controller do
    def permitted_params
      params.permit menu: [:title, :name, :description, :able, :translit]
    end
  end
end


