# app/models/cart_item.rb
class CartItem < ApplicationRecord
    belongs_to :product
    belongs_to :cart
   # Set a default value for quantity
  attribute :quantity, :integer, default: 0
  def total_price
    product.price * quantity
  end
  end
  