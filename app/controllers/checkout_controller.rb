class CheckoutController < ApplicationController
  before_action :authenticate_user! 

  def new
    @cart = session[:cart] || {}
    @order = current_user.orders.build
    @subtotal = calculate_cart_total
    @taxes = calculate_taxes(@subtotal)
    @total = @subtotal + @taxes
  end

  def create
    @cart = session[:cart] || {}
    @order = current_user.orders.build(order_params)
    @order.order_items = session[:cart].map do |product_id, quantity|
      product = Product.find(product_id)
      OrderItem.new(product: product, quantity: quantity, price: product.price)
    end
    @order.total_amount = @order.order_items.sum { |item| item.price * item.quantity } + calculate_taxes(@order.order_items.sum { |item| item.price * item.quantity })

    if @order.save
      session[:cart] = {} # Clear the cart after successful checkout
      redirect_to checkout_index_path, notice: 'Order placed successfully!'
    else
      render :new
    end
  end

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
