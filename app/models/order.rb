<<<<<<< HEAD
class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  has_many :order_items
  accepts_nested_attributes_for :order_items
  attr_accessor :hst, :gst, :pst
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "product_id", "quantity", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "order_items.product"]
  end
=======
# app/models/order.rb

class Order < ApplicationRecord
belongs_to :user, optional: true
  belongs_to :guest_user, class_name: 'GuestUser', foreign_key: 'guest_user_id', optional: true
  has_many :cart_items
  belongs_to :customer, optional: true
  has_many :order_items
  belongs_to :user_address

  # Ensure these attributes are accessible
  attr_accessor :subtotal, :gst_amount, :pst_amount, :hst_amount, :tax, :grand_total

  # Other validations and methods for the Order model
>>>>>>> 3b64b9dd9150b006b7b2651e2644892e4e29d7c3
end
