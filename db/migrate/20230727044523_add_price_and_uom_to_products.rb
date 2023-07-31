class AddPriceAndUomToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :price, :decimal
    add_column :products, :uom, :string
  end
end
