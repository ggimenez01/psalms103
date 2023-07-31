class ApplicationController < ActionController::Base
  before_action :initialize_cart
  helper_method :cart_items_count, :logged_in?, :checkout_url

  private

  def checkout_url
    front_page_checkout_path
  end

  def cart_items_count
    @cart_items_count ||= current_cart.cart_items.sum(:quantity)
  end

  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id]) || Cart.new
  end

  def initialize_cart
    session[:cart] ||= {}
  end

  def logged_in?
    user_signed_in?
  end

  def set_cart_items_count
    if current_cart
      @cart_items_count = current_cart.cart_items.sum(:quantity)
    else
      @cart_items_count = 0
    end
  end

  def bypass_authentication_for_checkout
    skip_before_action :authenticate_user!
  end
end
