<<<<<<< HEAD
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "price", "product_id", "quantity", "updated_at"]
  end
=======
# app/models/order_item.rb

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :user_address

  # Other attributes and methods for the OrderItem model
>>>>>>> 3b64b9dd9150b006b7b2651e2644892e4e29d7c3
end
