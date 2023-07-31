class CheckoutController < ApplicationController
  before_action :authenticate_user!, except: [:show, :guest_user_checkout, :confirmation, :update_checkout, :update_province]
  include CheckoutHelper
  def show
    if user_signed_in?
      @user_address = current_user.user_addresses.first || UserAddress.new
      @cart_items = current_cart.cart_items.includes(:product)
      @provinces_options = provinces_options # Make sure this method is defined and provides the necessary options.
      @province_tax = calculate_province_tax(@user_address.province) # Make sure this method is defined and returns the correct tax rate.
      @total_cart_price = calculate_total_cart_price(@cart_items, @province_tax) # Make sure this method is defined and returns the total price.
  
      @gst_amount = TaxCalculator.calculate_tax_amount(@total_cart_price, 'gst')
      @pst_amount = TaxCalculator.calculate_tax_amount(@total_cart_price, 'pst')
      @hst_amount = TaxCalculator.calculate_tax_amount(@total_cart_price, 'hst')
  
      @grand_total = @total_cart_price + @gst_amount + @pst_amount + @hst_amount
    else
      @user_address = UserAddress.new
      @cart_items = current_cart.cart_items.includes(:product)
      @provinces_options = provinces_options # Make sure this method is defined and provides the necessary options.
    end
  
    puts @provinces_options.to_json
  end
  
  
  
  
  def update
    @user_address = UserAddress.find(params[:id])
    if @user_address.update(user_address_params)
      redirect_to confirmation_path # Or wherever you want to redirect after a successful update
    else
      render :edit
    end
  end

  def confirmation
    @order = Order.new
    @user_address = guest_user_address
    @cart_items = current_cart.cart_items.includes(:product)
    @order.guest_user = current_cart.guest_user
    
    @order.subtotal = @cart_items.sum { |cart_item| cart_item.total_price }
  
    if user_signed_in?
      @user_address = current_user.address
      @cart_items = current_cart.cart_items.includes(:product)
      @order.customer = current_user
    else
      @user_address = guest_user_address
      @cart_items = current_cart.cart_items.includes(:product)
      @order.guest_user = current_cart.guest_user
    end
  
    @order.subtotal = @cart_items.sum { |cart_item| cart_item.total_price }
    @order.gst_amount = TaxCalculator.calculate_tax_amount(@order.subtotal, 'gst')
    @order.pst_amount = TaxCalculator.calculate_tax_amount(@order.subtotal, 'pst')
    @order.hst_amount = TaxCalculator.calculate_tax_amount(@order.subtotal, 'hst')
    @order.tax = @order.gst_amount + @order.pst_amount + @order.hst_amount
    @order.grand_total = @order.subtotal + @order.tax
  
    @order.order_number = generate_unique_order_number
  
    if @order.save
      @cart_items.each do |cart_item|
        @order.cart_items.create(
          product: cart_item.product,
          quantity: cart_item.quantity,
          subtotal: cart_item.total_price
        )
      end
    else
      # Handle error here, e.g., redirect to an error page or display an error message
      # You can also check the logs to see the specific error details.
    end
  
    # Render the confirmation page
    render 'checkout/confirmation/show'
  end
  

  def province_tax_rates
    selected_province = params[:province]
    province_tax_rates = provinces_options[selected_province]
    render json: province_tax_rates
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

  def guest_user_checkout
    puts "Executing guest_user_checkout action..."
    @user_address = guest_user_address
    @cart_items = current_cart.cart_items.includes(:product)
    @province_tax = calculate_province_tax(@user_address.province)
    @total_cart_price = calculate_total_cart_price(@cart_items, @province_tax)
    render :show
  end

  private

  def generate_unique_order_number
    # Implement your logic here to generate a unique order number, such as using a UUID or combination of other identifiers.
    # For example:
    SecureRandom.uuid
  end

  def guest_user_address
    Address.new(
      address_line_1: params[:address_line_1],
      address_line_2: params[:address_line_2],
      city: params[:city],
      province: params[:province],
      postal_code: params[:postal_code]
    )
  end

  def calculate_province_tax(province)
    tax_rates = {
      'Alberta' => 0.05,
      'British Columbia' => 0.07,
      'Manitoba' => 0.07,
      'New Brunswick' => 0.0,
      'Newfoundland and Labrador' => 0.0,
      'Northwest Territories' => 0.05,
      'Nova Scotia' => 0.0,
      'Nunavut' => 0.05,
      'Ontario' => 0.0,
      'Prince Edward Island' => 0.0,
      'Quebec' => 0.10,
      'Saskatchewan' => 0.06,
      'Yukon' => 0.05
    }
  
    tax_rates[province] || 0.0 # Default to 0% tax if province is not found.
  end

  def calculate_total_cart_price(cart_items, province_tax)
    # Calculate the total price of all items in the cart
    total_price = cart_items.sum { |item| item.product.price * item.quantity }
  
    # Calculate the tax amount based on the total price and the province tax rate
    tax_amount = total_price * province_tax
  
    # Add the tax amount to the total price to get the final total cart price
    total_cart_price = total_price + tax_amount
  
    total_cart_price
  end

  def find_or_create_guest_user
    if session[:guest_user_id].present?
      GuestUser.find_by(id: session[:guest_user_id])
    else
      guest_user = GuestUser.create(name: 'Guest User', email: 'guest@example.com')
      session[:guest_user_id] = guest_user.id
      guest_user
    end
  end

  def redirect_to_login_for_non_logged_in_user
    redirect_to new_user_session_path(redirect_to: checkout_show_path) unless user_signed_in?
  end

  def calculate_total_taxes(user)
    if user.is_a?(GuestUser)
      # Handle the case when the user is a GuestUser without an address
      default_tax_rate = 0.1
      total_taxes = default_tax_rate * user.current_cart&.cart_items&.sum(:quantity) * user.current_cart&.cart_items&.sum(:product_price)
    else
      province_tax_rate = ProvinceTaxRate.find_by(province: user.address&.province)

      if province_tax_rate
        pst = province_tax_rate.pst
        gst = province_tax_rate.gst
        hst = province_tax_rate.hst

        # Calculate taxes based on the user's province and tax rates
        total_taxes = (pst + gst + hst) * user.current_cart&.cart_items&.sum(:quantity) * user.current_cart&.cart_items&.sum(:product_price)
      else
        # Default tax calculation if the province tax rate is not found
        # You can implement your default tax calculation logic here
        # For example, you can use a fixed tax rate for provinces without specific rates
        default_tax_rate = 0.1
        total_taxes = default_tax_rate * user.current_cart&.cart_items&.sum(:quantity) * user.current_cart&.cart_items&.sum(:product_price)
      end
    end

    total_taxes
  end

 def user_address_params
  params.require(:user_address).permit(:name, :address_line_1, :address_line_2, :city, :province, :postal_code)
end

  def calculate_subtotal(cart_items)
    cart_items.sum { |cart_item| cart_item.total_price }
  end
  
  def calculate_tax(subtotal, province_tax)
    # Implement your tax calculation logic here
  end

  def create_guest_user
    # Implement the guest user creation logic here
    # For example, you can create a GuestUser record or store guest details in the session
    # You may also want to set the guest user ID in the session to remember the guest user

    # For example, if you have a GuestUser model, you can do something like:
    guest_user = GuestUser.create(name: 'Guest User', email: 'guest@example.com')
    session[:guest_user_id] = guest_user.id
  end

  def guest_user
    @guest_user ||= begin
      if session[:guest_user_id].present?
        GuestUser.find_by(id: session[:guest_user_id])
      else
        guest_user = GuestUser.create(name: 'Guest User', email: 'guest@example.com')
        session[:guest_user_id] = guest_user.id
        guest_user
      end
    end
  end
end
