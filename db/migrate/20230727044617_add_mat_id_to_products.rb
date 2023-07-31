class AddMatIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :mat_id, :string
  end
end
