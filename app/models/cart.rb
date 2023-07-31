# app/models/cart.rb
class Cart < ApplicationRecord
  belongs_to :guest_user, optional: true
  has_many :cart_items, dependent: :destroy

  def add_product(product, quantity)
    cart_item = cart_items.find_or_initialize_by(product_id: product.id)
    cart_item.quantity += quantity
    cart_item.save!
  end
end
