class GuestUser < ApplicationRecord
    has_one :cart, dependent: :destroy
   
    belongs_to :user, optional: true
    has_many :orders
    attr_accessor :address
    def current_cart
        cart || create_cart
      end
end
