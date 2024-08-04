class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_cart

  def index
    @orders = current_user.orders
  end

  def new
    @order = current_user.orders.build
    @cart_total = calculate_cart_total
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.calculate_taxes
    if @order.save
      redirect_to order_confirmation_path(@order), notice: 'Order placed successfully'
    else
      render :new
    end
  end

  private

  def initialize_cart
    @cart = session[:cart] || {}
  end

  def calculate_cart_total
    @cart.sum { |product_id, quantity| Product.find(product_id).price * quantity } || 0
  end

  def order_params
    params.require(:order).permit(:total_amount, :status, order_items_attributes: [:product_id, :quantity, :price])
  end
end
