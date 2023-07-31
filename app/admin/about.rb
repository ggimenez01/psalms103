# app/admin/about.rb
ActiveAdmin.register About do
  permit_params :title, :content

  form do |f|
    f.semantic_errors # Shows errors on :base
    f.inputs do
      f.input :title
      f.input :content, as: :ckeditor
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content do |about|
        sanitize(about.content)
      end
    end
  end
end
