class CartsController < ApplicationController
  def show
    @cart = Cart.new(session)
  end

  def add
    product = Product.find(params[:product_id])
    @cart = Cart.new(session)
    @cart.add_product(product.id)
    redirect_to cart_path
  end

  def remove
    product = Product.find(params[:product_id])
    @cart = Cart.new(session)
    @cart.remove_product(product.id)
    redirect_to cart_path
  end

  def clear
    @cart = Cart.new(session)
    @cart.clear
    redirect_to cart_path
  end
end
