ActiveAdmin.register Order do
  controller do
    def permitted_params
      params.permit order: [:payed, :name, :email, :cool_time1, :cool_time2, :akey, :pay_way, :end_cards, :sum_for_pay, :when_payed, :akey_payed, :able]
    end
  end
end


      


