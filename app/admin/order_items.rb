ActiveAdmin.register OrderItem do
  permit_params :order_id, :product_id, :quantity, :price

  index do
    selectable_column
    id_column
    column :order
    column :product
    column :quantity
    column :price
    actions
  end

  filter :order
  filter :product
  filter :quantity
  filter :price

  form do |f|
    f.inputs do
      f.input :order
      f.input :product
      f.input :quantity
      f.input :price
    end
    f.actions
  end
end
