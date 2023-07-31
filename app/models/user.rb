class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
<<<<<<< HEAD
end
=======
         has_many :user_addresses
         has_one :guest_user, foreign_key: 'user_id', dependent: :destroy
       
         # Define the create_guest_user method to create a guest user
         def self.create_guest_user
           user = User.new
           user.email = generate_guest_email # Customize this method to generate a unique guest email
           user.password = Devise.friendly_token[0, 20] # Generate a random password
           user.save(validate: false) # Save the user without validation
       
           # Create and associate the guest_user record with the user
           user.create_guest_user_record
       
           user
         end
       
         def create_order_with_cart_items(cart_item_ids)
           if guest_user
             order = guest_user.orders.build # Use the association to build the order
           else
             order = orders.build # Use the association to build the order for logged-in users
           end
       
           cart_items = CartItem.where(id: cart_item_ids)
           cart_items.each { |cart_item| order.order_items.build(product: cart_item.product, quantity: cart_item.quantity) }
           order.save
           order
         end
       
         # Public method to create a guest_user record and associate it with the user
         def create_guest_user_record
           guest_user = GuestUser.create(user: self)
           guest_user.save(validate: false)
         end
       
         private
       
         # Customize this method to generate a unique guest email based on your requirements
         def self.generate_guest_email
           # For example, you can use a timestamp and a random number to generate a unique email
           "guest_#{Time.now.to_i}_#{rand(1000..9999)}@example.com"
         end
       end
>>>>>>> 3b64b9dd9150b006b7b2651e2644892e4e29d7c3
