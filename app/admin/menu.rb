ActiveAdmin.register Menu do
  controller do
    def permitted_params
      params.permit menu: [:title, :description, :able, :price, :name, :translit]
    end
  end
end


