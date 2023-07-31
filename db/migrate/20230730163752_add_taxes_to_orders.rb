class AddTaxesToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :hst, :decimal, precision: 8, scale: 2, default: 0
    add_column :orders, :gst, :decimal, precision: 8, scale: 2, default: 0
    add_column :orders, :pst, :decimal, precision: 8, scale: 2, default: 0
  end
end
