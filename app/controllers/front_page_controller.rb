class FrontPageController < ApplicationController
  def index
    if params[:on_sale]
      @products = Product.where(on_sale: true).page(params[:page]).per(10)
    elsif params[:new_products]
      @products = Product.order(created_at: :desc).page(params[:page]).per(10)
    elsif params[:recently_updated]
      @products = Product.order(updated_at: :desc).page(params[:page]).per(10)
    elsif params[:category_id].present? || params[:keyword].present?
      @products = search_products.page(params[:page]).per(10)
    else
      @products = Product.page(params[:page]).per(10)
    end

    # Fetch the contact information
    @contact = Contact.first
  end

  def search_products
    products = Product.all

    if params[:category_id].present?
      products = products.where(category_id: params[:category_id])
    end

    if params[:keyword].present?
      products = products.where("name LIKE ?", "%#{params[:keyword]}%")
    end

    products
  end

  def category
    @category = Category.find(params[:category_id])
    @keyword = params[:keyword]
    @products = @category.products
    @products = @products.where('name LIKE ?', "%#{@keyword}%") if @keyword.present?
    @products = @products.page(params[:page]).per(10)

    # Fetch the contact information
    @contact = Contact.first

    render 'index'
  end
  def show
    @product = Product.find(params[:id])
  end






 

  def add_to_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    current_cart.add_product(product, quantity)

    redirect_to front_page_path, notice: "#{product.name} added to cart."
  end
  def view_cart
    @cart_items = current_cart.cart_items.includes(:product)
    @total_cart_price = @cart_items.sum { |item| item.total_price.to_d }
  end
  
  

  def update_cart_item
  cart_item = CartItem.find(params[:cart_item_id])
  quantity = params[:quantity].to_i

  cart_item.update(quantity: quantity)

  redirect_to view_cart_path, notice: "Quantity updated."
end

def remove_from_cart
  cart_item = CartItem.find(params[:cart_item_id])
  cart_item.destroy

  redirect_to view_cart_path, notice: "Item removed from cart."
end

  private

  def current_cart
    if current_user
      # If the user is logged in, associate the cart with the user
      current_user.cart ||= Cart.create
    else
      # If the user is not logged in, use the session to store the cart
      session[:cart_id] ||= Cart.create.id
      Cart.find(session[:cart_id])
    end
  end
end