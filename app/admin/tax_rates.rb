# app/admin/tax_rates.rb
ActiveAdmin.register TaxRate do
  permit_params :province_id, :gst_rate, :pst_rate, :hst_rate
end
