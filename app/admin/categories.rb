# app/admin/category.rb
ActiveAdmin.register Category do
  permit_params :name, :description

  form do |f|
    f.semantic_errors # Shows errors on :base
    f.inputs do
      f.input :name
      f.input :description, as: :text
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name do |category|
      link_to category.name, admin_category_path(category)
    end
    column :description
    column :products_count do |category|
      link_to category.products.count, admin_products_path(q: { category_id_eq: category.id })
    end
    column :created_at
    column :updated_at
    actions
  end
end

