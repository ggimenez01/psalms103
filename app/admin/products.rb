# app/admin/products.rb
ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :supplier_id, :mat_id, :uom, :image, :on_sale

  filter :name
  filter :price
  filter :on_sale
  form do |f|
    f.semantic_errors *f.object.errors.attribute_names.map(&:to_sym)
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :on_sale
    end
    f.inputs "Images" do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image.url, height: "150") : content_tag(:span, "No image yet")
      f.input :image_cache, as: :hidden
      f.input :remove_image, as: :boolean, required: false, label: 'Remove Image'
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :image do |product|
      if product.image.present?
        link_to image_tag(product.image.url, height: "50"), product.image.url
      else
        content_tag(:span, "No image")
      end
    end
    column :name
    column :description
    column :uom
    column :price
    column :category
    column :on_sale
    actions
  end

  show do
    attributes_table do
      row :image do |product|
        if product.image.present?
          image_tag product.image.url, height: "150"
        else
          content_tag(:span, "No image")
        end
      end
      row :name
      row :description
      row :supplier
      row :mat_id
      row :uom
      row :price
      row :category
      row :on_sale
      row :created_at
      row :updated_at
    end
  end
end
