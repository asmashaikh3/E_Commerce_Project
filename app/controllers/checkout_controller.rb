class CheckoutController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in before checking out

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

  private

  def calculate_cart_total
    session[:cart].sum do |product_id, quantity|
      product = Product.find(product_id)
      product.price * quantity
    end
  end

  def calculate_taxes(subtotal)
    province = Province.find_by(id: current_user.province_id)
  
    if province
      gst = subtotal * (province.gst / 100.0)
      pst = subtotal * (province.pst / 100.0)
      hst = subtotal * (province.hst / 100.0)
      qst = subtotal * (province.qst / 100.0)
  
      gst + pst + hst + qst
    else
      0
    end
  end

  def order_params
    params.require(:order).permit(:address, :province_id)
  end
end
