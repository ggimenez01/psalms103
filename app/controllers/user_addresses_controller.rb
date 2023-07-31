class UserAddressesController < ApplicationController
    
    def update
      @user_address = current_user.user_addresses.first_or_initialize(user_address_params)
  
      if @user_address.save
        # Get the array of cart item IDs submitted in the form
        cart_item_ids = params[:cart_item_ids]
  
        # Create a new order or find an existing order
        order = current_user.orders.build
  
        # Add the cart items to the order
        cart_items = CartItem.where(id: cart_item_ids)
        cart_items.each { |cart_item| order.order_items.build(product: cart_item.product, quantity: cart_item.quantity) }
  
        # Save the order
        order.save
  
        # Redirect to the confirmation page or wherever you want to redirect after successful submission
        redirect_to confirmation_path, notice: 'Shipping address and order have been updated and placed successfully.'
      else
        render :show
      end
    end
    def create
        if user_signed_in?
          @user_address = current_user.user_addresses.build(user_address_params)
        else
          # For non-logged-in users, create a guest user and associate the address with the order
          guest_user = User.create_guest_user
          @user_address = guest_user.user_addresses.build(user_address_params)
        end
      
        if @user_address.save
          # Get the array of cart item IDs submitted in the form
          cart_item_ids = params[:cart_item_ids]
      
          # Create a new order or find an existing order for the user or guest user
          order = user_signed_in? ? current_user.create_order_with_cart_items(cart_item_ids) : guest_user.create_order_with_cart_items(cart_item_ids)
      
          # Save the order
          order.save
      
          # Redirect to the correct confirmation page
          if user_signed_in?
            redirect_to confirmation_path(user_address: @user_address, cart_item_ids: cart_item_ids), notice: 'Address was successfully created.'
          else
            redirect_to confirmation_guest_path(user_address_params: user_address_params, cart_item_ids: cart_item_ids), notice: 'Address was successfully created.'
          end
        else
          render :show
        end
      end
      
      
      def confirmation_guest
        # Permit cart_item_ids and user_address_params
        cart_item_ids = params[:cart_item_ids]
        user_address_params = params[:user_address_params].permit(:name, :address_line_1, :address_line_2, :city, :province, :postal_code)
    
        # Fetch the shipping address based on user_address_params
        @user_address = UserAddress.new(user_address_params)
    
        # Fetch the cart items based on the cart_item_ids
        @cart_items = CartItem.where(id: cart_item_ids)
    
        # Calculate the subtotal of the cart items
        @subtotal = calculate_subtotal(@cart_items)
    
        # Calculate the tax amounts based on the user's province
        province_tax_rates = provinces_options[@user_address.province]
        @gst_amount = province_tax_rates[:gst] * @subtotal
        @pst_amount = province_tax_rates[:pst] * @subtotal
        @hst_amount = province_tax_rates[:hst] * @subtotal
    
        # Calculate the grand total
        @grand_total = @subtotal + @gst_amount + @pst_amount + @hst_amount
    
        render 'confirmation_guest'
      end

     
    
      
      private

      def calculate_subtotal(cart_items)
        # Calculate the total price of all items in the cart
        cart_items.sum { |item| item.product.price * item.quantity }
      end

      def provinces_options
        @provinces_options ||= {
          'Alberta' => { pst: 0.00, gst: 0.05, hst: 0.00 },
          'British Columbia' => { pst: 0.07, gst: 0.05, hst: 0.00 },
          'Manitoba' => { pst: 0.07, gst: 0.05, hst: 0.00 },
          'New Brunswick' => { pst: 0.00, gst: 0.00, hst: 0.15 },
          'Newfoundland and Labrador' => { pst: 0.00, gst: 0.00, hst: 0.15 },
          'Northwest Territories' => { pst: 0.00, gst: 0.05, hst: 0.00 },
          'Nova Scotia' => { pst: 0.00, gst: 0.00, hst: 0.15 },
          'Nunavut' => { pst: 0.00, gst: 0.05, hst: 0.00 },
          'Ontario' => { pst: 0.00, gst: 0.00, hst: 0.13 },
          'Prince Edward Island' => { pst: 0.00, gst: 0.00, hst: 0.15 },
          'Quebec' => { pst: 0.10, gst: 0.05, hst: 0.00 },
          'Saskatchewan' => { pst: 0.06, gst: 0.05, hst: 0.00 },
          'Yukon' => { pst: 0.00, gst: 0.05, hst: 0.00 }
          # Add other provinces and their corresponding tax rates here.
        }
      end
      
      def user_address_params
        params.require(:user_address).permit(:name, :address_line_1, :address_line_2, :city, :province, :postal_code)
      end

    end