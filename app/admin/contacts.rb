ActiveAdmin.register Contact do
  permit_params :name, :email, :address, :phone_number

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address
    column :phone_number
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :address
      f.input :phone_number
    end
    f.actions
  end
end
