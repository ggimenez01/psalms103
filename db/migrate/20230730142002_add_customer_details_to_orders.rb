class AddCustomerDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :name, :string
    add_column :orders, :address, :string
    add_column :orders, :email, :string
    add_column :orders, :province_id, :integer
  end
end
