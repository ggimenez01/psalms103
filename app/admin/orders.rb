ActiveAdmin.register Order do
  filter :id
  filter :customer
  filter :product
  filter :quantity
  filter :created_at
  filter :updated_at
end
