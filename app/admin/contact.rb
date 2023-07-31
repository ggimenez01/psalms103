# app/admin/contact.rb
ActiveAdmin.register Contact do
  permit_params :title, :address, :telephone_number, :email, :website

  form do |f|
    f.semantic_errors # Shows errors on :base
    f.inputs do
      f.input :title
      f.input :address
      f.input :telephone_number
      f.input :email
      f.input :website
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :address
      row :telephone_number
      row :email
      row :website
    end
  end
end
