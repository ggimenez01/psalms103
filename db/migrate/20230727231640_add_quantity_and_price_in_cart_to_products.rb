class AddQuantityAndPriceInCartToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :quantity_in_cart, :integer
    add_column :products, :price_in_cart, :decimal
  end
end
